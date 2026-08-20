import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../config/ghana.dart';
import '../models/models.dart';
import '../providers/auth.dart';
import '../providers/repository.dart';
import '../utils/formatters.dart';
import '../db/password.dart';
import 'form_scaffold.dart';

/// Every remaining create/edit form in the app.
///
/// Each one writes to the database through `ChurchRepository` and is scoped to
/// the signed-in user's branch, so a Branch Pastor cannot file a record against
/// a branch they cannot see. Grouped in one file because they share the same
/// shape — [FormDialog] plus a handful of fields.

/* -------------------------------------------------------------- giving */

/// One form for both recording and correcting a gift.
///
/// Pass [donation] to edit it. Every create form in this file follows the same
/// shape, so "edit" is never a second, separately-maintained screen that can
/// drift out of step with the one used to enter the record.
Future<void> showDonationForm(BuildContext context, {Donation? donation}) =>
    showDialog<void>(
      context: context,
      builder: (_) => _DonationForm(donation: donation),
    );

class _DonationForm extends ConsumerStatefulWidget {
  const _DonationForm({this.donation});

  final Donation? donation;

  @override
  ConsumerState<_DonationForm> createState() => _DonationFormState();
}

class _DonationFormState extends ConsumerState<_DonationForm> {
  final _amount = TextEditingController();
  final _donor = TextEditingController();
  final _reference = TextEditingController();

  String? _branchId;
  String? _memberId;
  GivingFund _fund = GivingFund.tithe;
  PaymentMethod _method = PaymentMethod.transfer;
  DateTime _date = DateTime.now().toUtc();
  bool _anonymous = false;

  @override
  void initState() {
    super.initState();
    final d = widget.donation;
    _branchId = d?.branchId ?? defaultBranchId(ref);
    if (d != null) {
      _amount.text = d.amount.toStringAsFixed(2);
      _donor.text = d.donorName;
      _reference.text = d.reference;
      _fund = d.fund;
      _method = d.method;
      _date = d.date;
      _memberId = d.memberId;
      _anonymous = d.memberId == null;
    }
  }

  @override
  void dispose() {
    _amount.dispose();
    _donor.dispose();
    _reference.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final amount = double.tryParse(_amount.text.replaceAll(',', '')) ?? 0;

    final editing = widget.donation != null;

    return FormDialog(
      title: editing ? 'Edit giving' : 'Record giving',
      description: 'Saved to the giving ledger for the chosen branch.',
      submitLabel: editing ? 'Save changes' : 'Record giving',
      successMessage: editing
          ? 'Updated to ${Fmt.currency(amount)}.'
          : 'Recorded ${Fmt.currency(amount)} to ${_fund.label}.',
      fields: [
        BranchField(
          value: _branchId,
          onChanged: (v) => setState(() {
            _branchId = v;
            _memberId = null;
          }),
        ),
        AmountField(controller: _amount),
        EnumField<GivingFund>(
          label: 'Fund',
          values: GivingFund.values,
          value: _fund,
          labelOf: (v) => v.label,
          onChanged: (v) => setState(() => _fund = v),
        ),
        EnumField<PaymentMethod>(
          label: 'Method',
          values: PaymentMethod.values,
          value: _method,
          labelOf: (v) => v.label,
          onChanged: (v) => setState(() => _method = v),
        ),
        DateField(
          label: 'Date received',
          value: _date,
          lastDate: DateTime.now(),
          onChanged: (v) => setState(() => _date = v),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          value: _anonymous,
          onChanged: (v) => setState(() => _anonymous = v),
          title: const Text('Anonymous gift'),
          subtitle: const Text('Record without attributing it to a member.'),
        ),
        if (!_anonymous)
          MemberField(
            branchId: _branchId,
            value: _memberId,
            label: 'Donor',
            required: false,
            onChanged: (v) => setState(() => _memberId = v),
          ),
        if (_anonymous)
          PlainTextField(
            label: 'Donor name',
            controller: _donor,
            hint: 'Anonymous',
          ),
        PlainTextField(
          label: 'Reference',
          controller: _reference,
          hint: 'Leave blank to generate one',
        ),
      ],
      onSubmit: () async {
        final member = _anonymous ? null : _memberId;
        final donorName = _anonymous
            ? (_donor.text.trim().isEmpty ? 'Anonymous' : _donor.text.trim())
            : ref.read(memberNameProvider(member));

        if (editing) {
          await ref.read(repositoryProvider).updateDonation(
                widget.donation!.id,
                donorName: donorName,
                amount: double.parse(_amount.text.replaceAll(',', '').trim()),
                fund: _fund,
                method: _method,
                date: _date,
                memberId: member,
              );
          return;
        }

        await ref.read(repositoryProvider).recordDonation(
              branchId: _branchId!,
              memberId: member,
              donorName: donorName,
              amount: double.parse(_amount.text.replaceAll(',', '').trim()),
              fund: _fund,
              method: _method,
              date: _date,
              reference: _reference.text.trim().isEmpty
                  ? null
                  : _reference.text.trim(),
            );
      },
    );
  }
}

Future<void> showExpenseForm(BuildContext context, {ExpenseRecord? expense}) =>
    showDialog<void>(
      context: context,
      builder: (_) => _ExpenseForm(expense: expense),
    );

class _ExpenseForm extends ConsumerStatefulWidget {
  const _ExpenseForm({this.expense});

  final ExpenseRecord? expense;

  @override
  ConsumerState<_ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends ConsumerState<_ExpenseForm> {
  final _vendor = TextEditingController();
  final _category = TextEditingController();
  final _amount = TextEditingController();

  String? _branchId;
  String? _approvedBy;
  ExpenseStatus _status = ExpenseStatus.pending;
  DateTime _date = DateTime.now().toUtc();

  @override
  void initState() {
    super.initState();
    final e = widget.expense;
    _branchId = e?.branchId ?? defaultBranchId(ref);
    if (e != null) {
      _vendor.text = e.vendor;
      _category.text = e.category;
      _amount.text = e.amount.toStringAsFixed(2);
      _status = e.status;
      _date = e.date;
      _approvedBy = e.approvedBy;
    }
  }

  @override
  void dispose() {
    _vendor.dispose();
    _category.dispose();
    _amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.expense != null;

    return FormDialog(
      title: editing ? 'Edit expense' : 'Record expense',
      description: 'Saved to the expense ledger for the chosen branch.',
      submitLabel: editing ? 'Save changes' : 'Record expense',
      successMessage: editing
          ? 'Updated the expense for ${_vendor.text.trim()}.'
          : 'Recorded expense for ${_vendor.text.trim()}.',
      fields: [
        BranchField(
          value: _branchId,
          onChanged: (v) => setState(() {
            _branchId = v;
            _approvedBy = null;
          }),
        ),
        PlainTextField(
          label: 'Vendor',
          controller: _vendor,
          hint: 'Electricity Company of Ghana',
          required: true,
        ),
        PlainTextField(
          label: 'Category',
          controller: _category,
          hint: 'Utilities',
          required: true,
        ),
        AmountField(controller: _amount),
        DateField(
          label: 'Date',
          value: _date,
          lastDate: DateTime.now(),
          onChanged: (v) => setState(() => _date = v),
        ),
        EnumField<ExpenseStatus>(
          label: 'Status',
          values: ExpenseStatus.values,
          value: _status,
          labelOf: (v) => v.label,
          onChanged: (v) => setState(() => _status = v),
        ),
        MemberField(
          branchId: _branchId,
          value: _approvedBy,
          label: 'Approved by',
          required: false,
          minimumAge: 21,
          onChanged: (v) => setState(() => _approvedBy = v),
        ),
      ],
      onSubmit: () => editing
          ? ref.read(repositoryProvider).updateExpense(
                widget.expense!.id,
                category: _category.text.trim(),
                vendor: _vendor.text.trim(),
                amount: double.parse(_amount.text.replaceAll(',', '').trim()),
                date: _date,
                status: _status,
              )
          : ref.read(repositoryProvider).recordExpense(
            branchId: _branchId!,
            category: _category.text.trim(),
            vendor: _vendor.text.trim(),
            amount: double.parse(_amount.text.replaceAll(',', '').trim()),
            date: _date,
            status: _status,
            approvedBy: _approvedBy,
          ),
    );
  }
}

/* ------------------------------------------------------------ attendance */

Future<void> showServiceRecordForm(
  BuildContext context, {
  AttendanceRecord? record,
}) =>
    showDialog<void>(
      context: context,
      builder: (_) => _ServiceRecordForm(record: record),
    );

class _ServiceRecordForm extends ConsumerStatefulWidget {
  const _ServiceRecordForm({this.record});

  final AttendanceRecord? record;

  @override
  ConsumerState<_ServiceRecordForm> createState() =>
      _ServiceRecordFormState();
}

class _ServiceRecordFormState extends ConsumerState<_ServiceRecordForm> {
  final _service = TextEditingController(text: 'First Service');
  final _adults = TextEditingController(text: '0');
  final _children = TextEditingController(text: '0');
  final _visitors = TextEditingController(text: '0');
  final _online = TextEditingController(text: '0');

  String? _branchId;
  DateTime _date = DateTime.now().toUtc();

  @override
  void initState() {
    super.initState();
    final r = widget.record;
    _branchId = r?.branchId ?? defaultBranchId(ref);
    if (r != null) {
      _service.text = r.serviceName;
      _adults.text = '${r.adults}';
      _children.text = '${r.children}';
      _visitors.text = '${r.visitors}';
      _online.text = '${r.online}';
      _date = r.date;
    }
  }

  @override
  void dispose() {
    for (final c in [_service, _adults, _children, _visitors, _online]) {
      c.dispose();
    }
    super.dispose();
  }

  Widget _count(String label, TextEditingController controller) => LabelledField(
        label: label,
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          validator: (v) =>
              int.tryParse((v ?? '').trim()) == null ? 'Enter a number' : null,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final editing = widget.record != null;

    return FormDialog(
      title: editing ? 'Edit service record' : 'New service record',
      description:
          'Headcounts for one service. Individual check-ins are recorded '
          'separately on the check-in tab.',
      submitLabel: editing ? 'Save changes' : 'Save record',
      successMessage:
          editing ? 'Service record updated.' : 'Service record saved.',
      fields: [
        BranchField(value: _branchId, onChanged: (v) => setState(() => _branchId = v)),
        PlainTextField(
          label: 'Service',
          controller: _service,
          hint: 'First Service',
          required: true,
        ),
        DateField(
          label: 'Date',
          value: _date,
          lastDate: DateTime.now(),
          onChanged: (v) => setState(() => _date = v),
        ),
        _count('Adults', _adults),
        _count('Children', _children),
        _count('Visitors', _visitors),
        _count('Online', _online),
      ],
      onSubmit: () => editing
          ? ref.read(repositoryProvider).updateAttendanceRecord(
                widget.record!.id,
                serviceName: _service.text.trim(),
                date: _date,
                adults: int.parse(_adults.text.trim()),
                children: int.parse(_children.text.trim()),
                visitors: int.parse(_visitors.text.trim()),
                online: int.parse(_online.text.trim()),
              )
          : ref.read(repositoryProvider).recordAttendance(
            branchId: _branchId!,
            date: _date,
            serviceName: _service.text.trim(),
            adults: int.parse(_adults.text.trim()),
            children: int.parse(_children.text.trim()),
            visitors: int.parse(_visitors.text.trim()),
            online: int.parse(_online.text.trim()),
          ),
    );
  }
}

/* ---------------------------------------------------------------- events */

Future<void> showEventForm(BuildContext context, {ChurchEvent? event}) =>
    showDialog<void>(
      context: context,
      builder: (_) => _EventForm(event: event),
    );

class _EventForm extends ConsumerStatefulWidget {
  const _EventForm({this.event});

  final ChurchEvent? event;

  @override
  ConsumerState<_EventForm> createState() => _EventFormState();
}

class _EventFormState extends ConsumerState<_EventForm> {
  final _title = TextEditingController();
  final _location = TextEditingController();
  final _expected = TextEditingController(text: '100');

  String? _branchId;
  String? _organizerId;
  EventCategory _category = EventCategory.service;
  DateTime _date = DateTime.now().toUtc().add(const Duration(days: 7));
  int _startHour = 10;
  int _hours = 2;
  bool _recurring = false;

  @override
  void initState() {
    super.initState();
    final e = widget.event;
    _branchId = e?.branchId ?? defaultBranchId(ref);
    if (e != null) {
      _title.text = e.title;
      _location.text = e.location;
      _expected.text = '${e.expectedAttendance}';
      _category = e.category;
      _date = e.startsAt;
      _startHour = e.startsAt.hour;
      _hours = e.endsAt.difference(e.startsAt).inHours.clamp(1, 12);
      _recurring = e.isRecurring;
      _organizerId = e.organizerId;
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _location.dispose();
    _expected.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.event != null;

    return FormDialog(
      title: editing ? 'Edit event' : 'Create event',
      description: 'Added to the calendar for the chosen branch.',
      submitLabel: editing ? 'Save changes' : 'Create event',
      successMessage: editing
          ? '"${_title.text.trim()}" updated.'
          : '"${_title.text.trim()}" added to the calendar.',
      fields: [
        BranchField(
          value: _branchId,
          onChanged: (v) => setState(() {
            _branchId = v;
            _organizerId = null;
          }),
        ),
        PlainTextField(
          label: 'Title',
          controller: _title,
          hint: 'Leaders\' Council',
          required: true,
        ),
        EnumField<EventCategory>(
          label: 'Category',
          values: EventCategory.values,
          value: _category,
          labelOf: (v) => v.label,
          onChanged: (v) => setState(() => _category = v),
        ),
        DateField(
          label: 'Date',
          value: _date,
          onChanged: (v) => setState(() => _date = v),
        ),
        Row(
          children: [
            Expanded(
              child: EnumField<int>(
                label: 'Starts at',
                values: List.generate(24, (i) => i),
                value: _startHour,
                labelOf: (h) => '${h.toString().padLeft(2, '0')}:00',
                onChanged: (v) => setState(() => _startHour = v),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: EnumField<int>(
                label: 'Duration',
                values: const [1, 2, 3, 4, 6, 8],
                value: _hours,
                labelOf: (h) => '$h hour${h == 1 ? '' : 's'}',
                onChanged: (v) => setState(() => _hours = v),
              ),
            ),
          ],
        ),
        PlainTextField(
          label: 'Location',
          controller: _location,
          hint: 'Main Auditorium',
        ),
        LabelledField(
          label: 'Expected attendance',
          child: TextFormField(
            controller: _expected,
            keyboardType: TextInputType.number,
            validator: (v) =>
                int.tryParse((v ?? '').trim()) == null ? 'Enter a number' : null,
          ),
        ),
        MemberField(
          branchId: _branchId,
          value: _organizerId,
          label: 'Organiser',
          required: false,
          minimumAge: 18,
          onChanged: (v) => setState(() => _organizerId = v),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          value: _recurring,
          onChanged: (v) => setState(() => _recurring = v),
          title: const Text('Repeats weekly'),
        ),
      ],
      onSubmit: () {
        final start = DateTime.utc(_date.year, _date.month, _date.day, _startHour);
        if (editing) {
          return ref.read(repositoryProvider).updateEvent(
                widget.event!.id,
                title: _title.text.trim(),
                category: _category,
                startsAt: start,
                endsAt: start.add(Duration(hours: _hours)),
                location: _location.text.trim(),
                expectedAttendance:
                    int.tryParse(_expected.text.trim()) ?? 0,
              );
        }
        return ref.read(repositoryProvider).createEvent(
              branchId: _branchId!,
              title: _title.text.trim(),
              category: _category,
              startsAt: start,
              endsAt: start.add(Duration(hours: _hours)),
              location: _location.text.trim(),
              organizerId: _organizerId,
              expectedAttendance: int.parse(_expected.text.trim()),
              isRecurring: _recurring,
            );
      },
    );
  }
}

/* ------------------------------------------------------------------ care */

Future<void> showCareForm(BuildContext context, {CareRequest? request}) =>
    showDialog<void>(
      context: context,
      builder: (_) => _CareForm(request: request),
    );

class _CareForm extends ConsumerStatefulWidget {
  const _CareForm({this.request});

  final CareRequest? request;

  @override
  ConsumerState<_CareForm> createState() => _CareFormState();
}

class _CareFormState extends ConsumerState<_CareForm> {
  final _summary = TextEditingController();

  String? _branchId;
  String? _memberId;
  String? _assignedToId;
  CareType _type = CareType.prayer;
  CarePriority _priority = CarePriority.medium;

  @override
  void initState() {
    super.initState();
    final r = widget.request;
    _branchId = r?.branchId ?? defaultBranchId(ref);
    if (r != null) {
      _summary.text = r.summary;
      _memberId = r.memberId;
      _assignedToId = r.assignedToId;
      _type = r.type;
      _priority = r.priority;
    }
  }

  @override
  void dispose() {
    _summary.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.request != null;

    return FormDialog(
      title: editing ? 'Edit care request' : 'Log a care request',
      description: 'Added to the pastoral care queue for the chosen branch.',
      submitLabel: editing ? 'Save changes' : 'Log request',
      successMessage:
          editing ? 'Care request updated.' : 'Care request logged.',
      fields: [
        BranchField(
          value: _branchId,
          onChanged: (v) => setState(() {
            _branchId = v;
            _memberId = null;
            _assignedToId = null;
          }),
        ),
        MemberField(
          branchId: _branchId,
          value: _memberId,
          label: 'Member',
          onChanged: (v) => setState(() => _memberId = v),
        ),
        EnumField<CareType>(
          label: 'Type',
          values: CareType.values,
          value: _type,
          labelOf: (v) => v.label,
          onChanged: (v) => setState(() => _type = v),
        ),
        EnumField<CarePriority>(
          label: 'Priority',
          values: CarePriority.values,
          value: _priority,
          labelOf: (v) => v.label,
          onChanged: (v) => setState(() => _priority = v),
        ),
        PlainTextField(
          label: 'Summary',
          controller: _summary,
          hint: 'What is needed, and any context the pastoral team should know',
          required: true,
          maxLines: 3,
        ),
        MemberField(
          branchId: _branchId,
          value: _assignedToId,
          label: 'Assign to',
          required: false,
          minimumAge: 21,
          onChanged: (v) => setState(() => _assignedToId = v),
        ),
      ],
      onSubmit: () => editing
          ? ref.read(repositoryProvider).updateCareRequest(
                widget.request!.id,
                type: _type,
                summary: _summary.text.trim(),
                priority: _priority,
                assignedToId: _assignedToId,
              )
          : ref.read(repositoryProvider).createCareRequest(
            branchId: _branchId!,
            memberId: _memberId!,
            type: _type,
            summary: _summary.text.trim(),
            priority: _priority,
            assignedToId: _assignedToId,
          ),
    );
  }
}

/* ---------------------------------------------------------------- assets */

Future<void> showAssetForm(BuildContext context, {AssetItem? asset}) =>
    showDialog<void>(
      context: context,
      builder: (_) => _AssetForm(asset: asset),
    );

class _AssetForm extends ConsumerStatefulWidget {
  const _AssetForm({this.asset});

  final AssetItem? asset;

  @override
  ConsumerState<_AssetForm> createState() => _AssetFormState();
}

class _AssetFormState extends ConsumerState<_AssetForm> {
  final _name = TextEditingController();
  final _category = TextEditingController();
  final _serial = TextEditingController();
  final _location = TextEditingController();
  final _value = TextEditingController();

  String? _branchId;
  AssetCondition _condition = AssetCondition.good;
  DateTime _purchased = DateTime.now().toUtc();

  @override
  void initState() {
    super.initState();
    _branchId = defaultBranchId(ref);
  }

  @override
  void dispose() {
    for (final c in [_name, _category, _serial, _location, _value]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.asset != null;

    return FormDialog(
      title: editing ? 'Edit asset' : 'Register asset',
      description: 'Added to the equipment register for the chosen branch.',
      submitLabel: editing ? 'Save changes' : 'Register asset',
      successMessage: editing
          ? '${_name.text.trim()} updated.'
          : '${_name.text.trim()} added to the register.',
      fields: [
        BranchField(value: _branchId, onChanged: (v) => setState(() => _branchId = v)),
        PlainTextField(
          label: 'Name',
          controller: _name,
          hint: 'Yamaha Digital Mixer',
          required: true,
        ),
        PlainTextField(
          label: 'Category',
          controller: _category,
          hint: 'Audio',
          required: true,
        ),
        AmountField(controller: _value, label: 'Value'),
        EnumField<AssetCondition>(
          label: 'Condition',
          values: AssetCondition.values,
          value: _condition,
          labelOf: (v) => v.label,
          onChanged: (v) => setState(() => _condition = v),
        ),
        DateField(
          label: 'Purchased',
          value: _purchased,
          lastDate: DateTime.now(),
          onChanged: (v) => setState(() => _purchased = v),
        ),
        PlainTextField(label: 'Serial number', controller: _serial),
        PlainTextField(
          label: 'Location',
          controller: _location,
          hint: 'Main Auditorium',
        ),
      ],
      onSubmit: () => editing
          ? ref.read(repositoryProvider).updateAsset(
                widget.asset!.id,
                name: _name.text.trim(),
                category: _category.text.trim(),
                serial: _serial.text.trim(),
                condition: _condition,
                location: _location.text.trim(),
                purchasedAt: _purchased,
                value: double.parse(_value.text.replaceAll(',', '').trim()),
              )
          : ref.read(repositoryProvider).createAsset(
            branchId: _branchId!,
            name: _name.text.trim(),
            category: _category.text.trim(),
            condition: _condition,
            purchasedAt: _purchased,
            value: double.parse(_value.text.replaceAll(',', '').trim()),
            serial: _serial.text.trim(),
            location: _location.text.trim(),
          ),
    );
  }
}

/* -------------------------------------------------------------- branches */

Future<void> showBranchForm(BuildContext context, {Branch? branch}) =>
    showDialog<void>(
      context: context,
      builder: (_) => _BranchForm(branch: branch),
    );

class _BranchForm extends ConsumerStatefulWidget {
  const _BranchForm({this.branch});

  final Branch? branch;

  @override
  ConsumerState<_BranchForm> createState() => _BranchFormState();
}

class _BranchFormState extends ConsumerState<_BranchForm> {
  final _name = TextEditingController();
  final _code = TextEditingController();
  final _address = TextEditingController();
  final _city = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _website = TextEditingController();
  String? _region;

  BranchStatus _status = BranchStatus.planting;
  AccentToken _accent = AccentToken.blue;
  DateTime _established = DateTime.now().toUtc();

  @override
  void initState() {
    super.initState();
    final b = widget.branch;
    if (b == null) return;

    _name.text = b.name;
    _code.text = b.code;
    _address.text = b.address.line1;
    _city.text = b.address.city;
    _phone.text = b.phone;
    _email.text = b.email;
    _website.text = b.website;
    _region = b.address.state.isEmpty ? null : b.address.state;
    _status = b.status;
    _accent = b.accent;
    _established = b.establishedAt;
  }

  @override
  void dispose() {
    for (final c in [
      _name,
      _code,
      _address,
      _city,
      _phone,
      _email,
      _website,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.branch != null;

    return FormDialog(
      title: editing ? 'Edit ${widget.branch!.name}' : 'Add branch',
      description: editing
          ? 'Its leadership is set separately, from the branch row or its '
              'detail view.'
          : 'A new campus. Its pastor and departments are assigned afterwards, '
              'once members have been added to it.',
      submitLabel: editing ? 'Save changes' : 'Add branch',
      successMessage: editing
          ? '${_name.text.trim()} updated.'
          : '${_name.text.trim()} added.',
      fields: [
        PlainTextField(
          label: 'Name',
          controller: _name,
          hint: 'Grace Chapel Enugu',
          required: true,
        ),
        PlainTextField(
          label: 'Short code',
          controller: _code,
          hint: 'ENU',
          required: true,
        ),
        PlainTextField(
          label: 'Address',
          controller: _address,
          hint: '12 Independence Layout',
          required: true,
        ),
        LabelledField(
          label: 'City or town',
          child: TextFormField(
            controller: _city,
            decoration: const InputDecoration(hintText: 'Kumasi'),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'City is required' : null,
            // Filling the region from a recognised city saves the common case,
            // and only when the user has not already chosen one.
            onChanged: (value) {
              if (_region != null) return;
              final inferred = Ghana.regionForCity(value);
              if (inferred != null) setState(() => _region = inferred);
            },
          ),
        ),
        RegionField(
          value: _region,
          onChanged: (v) => setState(() => _region = v),
        ),
        EnumField<BranchStatus>(
          label: 'Status',
          values: BranchStatus.values,
          value: _status,
          labelOf: (v) => v.label,
          onChanged: (v) => setState(() => _status = v),
        ),
        AccentField(
          value: _accent,
          onChanged: (v) => setState(() => _accent = v),
        ),
        DateField(
          label: 'Established',
          value: _established,
          lastDate: DateTime.now(),
          onChanged: (v) => setState(() => _established = v),
        ),
        PhoneField(
          label: 'Phone',
          controller: _phone,
          required: false,
        ),
        PlainTextField(
          label: 'Email',
          controller: _email,
          hint: 'accra@kgc.org',
        ),
        PlainTextField(
          label: 'Website',
          controller: _website,
          hint: 'kgc.org/accra',
        ),
      ],
      onSubmit: () => editing
          ? ref.read(repositoryProvider).updateBranch(
                widget.branch!.id,
                name: _name.text.trim(),
                code: _code.text.trim(),
                addressLine: _address.text.trim(),
                city: _city.text.trim(),
                state: _region ?? '',
                status: _status,
                accent: _accent,
                establishedAt: _established,
                phone: _phone.text.trim(),
                email: _email.text.trim(),
                website: _website.text.trim(),
              )
          : ref.read(repositoryProvider).createBranch(
            name: _name.text.trim(),
            code: _code.text.trim(),
            addressLine: _address.text.trim(),
            city: _city.text.trim(),
            state: _region ?? '',
            status: _status,
            establishedAt: _established,
            accent: _accent,
            phone: _phone.text.trim(),
            email: _email.text.trim(),
            website: _website.text.trim(),
          ),
    );
  }
}

/// Assigns a branch's pastor and assistant — "add branch head".
Future<void> showBranchLeadershipForm(
  BuildContext context, {
  required Branch branch,
}) =>
    showDialog<void>(
      context: context,
      builder: (_) => _BranchLeadershipForm(branch: branch),
    );

class _BranchLeadershipForm extends ConsumerStatefulWidget {
  const _BranchLeadershipForm({required this.branch});

  final Branch branch;

  @override
  ConsumerState<_BranchLeadershipForm> createState() =>
      _BranchLeadershipFormState();
}

class _BranchLeadershipFormState
    extends ConsumerState<_BranchLeadershipForm> {
  String? _pastorId;
  String? _assistantId;

  @override
  void initState() {
    super.initState();
    _pastorId = widget.branch.pastorId.isEmpty ? null : widget.branch.pastorId;
    _assistantId = widget.branch.assistantPastorId;
  }

  @override
  Widget build(BuildContext context) {
    return FormDialog(
      title: 'Branch leadership',
      description:
          'Both must be members of ${widget.branch.name} — a branch is led by '
          'someone who belongs to it.',
      submitLabel: 'Save leadership',
      successMessage: 'Leadership updated for ${widget.branch.name}.',
      fields: [
        MemberField(
          branchId: widget.branch.id,
          value: _pastorId,
          label: 'Branch pastor',
          minimumAge: 21,
          onChanged: (v) => setState(() => _pastorId = v),
        ),
        MemberField(
          branchId: widget.branch.id,
          value: _assistantId,
          label: 'Assistant pastor',
          required: false,
          minimumAge: 21,
          onChanged: (v) => setState(() => _assistantId = v),
        ),
      ],
      onSubmit: () => ref.read(repositoryProvider).setBranchLeadership(
            widget.branch.id,
            pastorId: _pastorId,
            assistantPastorId: _assistantId,
          ),
    );
  }
}

/* ---------------------------------------------------------------- access */

/// Creates a sign-in account, so a branch pastor or department head can log in.
Future<void> showInviteUserForm(BuildContext context) => showDialog<void>(
      context: context,
      builder: (_) => const _InviteUserForm(),
    );

class _InviteUserForm extends ConsumerStatefulWidget {
  const _InviteUserForm();

  @override
  ConsumerState<_InviteUserForm> createState() => _InviteUserFormState();
}

class _InviteUserFormState extends ConsumerState<_InviteUserForm> {
  final _name = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();

  UserRole _role = UserRole.branchAdmin;
  String? _branchId;
  String? _departmentId;

  @override
  void initState() {
    super.initState();
    _branchId = defaultBranchId(ref);
  }

  @override
  void dispose() {
    _name.dispose();
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Department-scoped roles need a department; others must not have one.
    final needsDepartment = _role.scope == RoleScope.ownDepartment;
    final departments = ref
        .watch(departmentsAllProvider)
        .where((d) => d.branchId == _branchId)
        .toList();

    return FormDialog(
      title: 'Invite user',
      description:
          'Creates a sign-in account. They can log in immediately with the '
          'password you set here.',
      submitLabel: 'Create account',
      successMessage: '${_name.text.trim()} can now sign in.',
      fields: [
        PlainTextField(
          label: 'Full name',
          controller: _name,
          hint: 'Esther Balogun',
          required: true,
        ),
        LabelledField(
          label: 'Username',
          hint: 'What they type to sign in. Letters, numbers, dots and dashes.',
          child: TextFormField(
            controller: _username,
            decoration: const InputDecoration(hintText: 'esther.asante'),
            validator: (v) {
              final value = (v ?? '').trim();
              if (value.isEmpty) return 'A username is required';
              if (value.length < 3) return 'At least three characters';
              if (!RegExp(r'^[a-zA-Z0-9._-]+$').hasMatch(value)) {
                return 'Letters, numbers, dots, dashes and underscores only';
              }
              return null;
            },
          ),
        ),
        LabelledField(
          label: 'Temporary password',
          hint: 'At least 8 characters, with a letter and a number.',
          child: TextFormField(
            controller: _password,
            decoration: const InputDecoration(hintText: 'e.g. grace2026start'),
            validator: (v) => Password.validate(v ?? ''),
          ),
        ),
        EnumField<UserRole>(
          label: 'Role',
          values: UserRole.values,
          value: _role,
          labelOf: (v) => '${v.label} · ${v.scope.label}',
          onChanged: (v) => setState(() {
            _role = v;
            _departmentId = null;
          }),
        ),
        BranchField(
          value: _branchId,
          onChanged: (v) => setState(() {
            _branchId = v;
            _departmentId = null;
          }),
        ),
        if (needsDepartment)
          LabelledField(
            label: 'Department',
            child: DropdownButtonFormField<String>(
              initialValue: _departmentId,
              isExpanded: true,
              hint: const Text('Choose a department'),
              items: [
                for (final d in departments)
                  DropdownMenuItem(
                    value: d.id,
                    child: Text(
                      ref.watch(departmentTypeByIdProvider(d.typeId))?.name ??
                          'Department',
                    ),
                  ),
              ],
              onChanged: (v) => setState(() => _departmentId = v),
              validator: (v) => v == null ? 'Choose a department' : null,
            ),
          ),
      ],
      onSubmit: () async {
        final repo = ref.read(repositoryProvider);
        if (await repo.usernameExists(_username.text)) {
          throw Exception('That username is already taken.');
        }
        await repo.createUser(
          name: _name.text.trim(),
          username: _username.text.trim(),
          password: _password.text,
          role: _role,
          branchId: _branchId,
          departmentId: needsDepartment ? _departmentId : null,
        );
      },
    );
  }
}

/* ---------------------------------------------------------- discipleship */

Future<void> showCourseForm(BuildContext context) => showDialog<void>(
      context: context,
      builder: (_) => const _CourseForm(),
    );

class _CourseForm extends ConsumerStatefulWidget {
  const _CourseForm();

  @override
  ConsumerState<_CourseForm> createState() => _CourseFormState();
}

class _CourseFormState extends ConsumerState<_CourseForm> {
  final _name = TextEditingController();
  final _description = TextEditingController();
  final _lessons = TextEditingController(text: '6');

  String? _branchId;
  String? _facilitatorId;

  @override
  void initState() {
    super.initState();
    _branchId = defaultBranchId(ref);
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    _lessons.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormDialog(
      title: 'New course',
      description: 'A discipleship course run at the chosen branch.',
      submitLabel: 'Create course',
      successMessage: '${_name.text.trim()} created.',
      fields: [
        BranchField(
          value: _branchId,
          onChanged: (v) => setState(() {
            _branchId = v;
            _facilitatorId = null;
          }),
        ),
        PlainTextField(
          label: 'Name',
          controller: _name,
          hint: 'Foundations of Faith',
          required: true,
        ),
        PlainTextField(
          label: 'Description',
          controller: _description,
          hint: 'What the course covers',
          maxLines: 2,
        ),
        LabelledField(
          label: 'Number of lessons',
          child: TextFormField(
            controller: _lessons,
            keyboardType: TextInputType.number,
            validator: (v) {
              final n = int.tryParse((v ?? '').trim());
              if (n == null) return 'Enter a number';
              if (n < 1) return 'A course needs at least one lesson';
              return null;
            },
          ),
        ),
        MemberField(
          branchId: _branchId,
          value: _facilitatorId,
          label: 'Facilitator',
          required: false,
          minimumAge: 21,
          onChanged: (v) => setState(() => _facilitatorId = v),
        ),
      ],
      onSubmit: () => ref.read(repositoryProvider).createCourse(
            branchId: _branchId!,
            name: _name.text.trim(),
            description: _description.text.trim(),
            lessons: int.parse(_lessons.text.trim()),
            facilitatorId: _facilitatorId,
          ),
    );
  }
}

/* ----------------------------------------------------- department editing */

Future<void> showDepartmentEditForm(
  BuildContext context, {
  required Department department,
  required String typeName,
}) =>
    showDialog<void>(
      context: context,
      builder: (_) => _DepartmentEditForm(
        department: department,
        typeName: typeName,
      ),
    );

class _DepartmentEditForm extends ConsumerStatefulWidget {
  const _DepartmentEditForm({
    required this.department,
    required this.typeName,
  });

  final Department department;
  final String typeName;

  @override
  ConsumerState<_DepartmentEditForm> createState() =>
      _DepartmentEditFormState();
}

class _DepartmentEditFormState extends ConsumerState<_DepartmentEditForm> {
  late final TextEditingController _notes;
  late Weekday _day;
  late String _time;
  String? _headId;
  String? _assistantId;

  @override
  void initState() {
    super.initState();
    _notes = TextEditingController(text: widget.department.notes ?? '');
    _day = widget.department.meetingDay;
    _time = widget.department.meetingTime;
    _headId = widget.department.headId.isEmpty ? null : widget.department.headId;
    _assistantId = widget.department.assistantHeadId;
  }

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const times = ['7:00 AM', '8:30 AM', '4:00 PM', '5:00 PM', '6:00 PM', '6:30 PM'];

    return FormDialog(
      title: 'Edit ${widget.typeName}',
      description:
          'Leadership and schedule. Members are managed separately from the '
          'card, so both can be changed independently.',
      submitLabel: 'Save changes',
      successMessage: '${widget.typeName} updated.',
      fields: [
        MemberField(
          branchId: widget.department.branchId,
          value: _headId,
          label: 'Department head',
          minimumAge: 21,
          onChanged: (v) => setState(() => _headId = v),
        ),
        MemberField(
          branchId: widget.department.branchId,
          value: _assistantId,
          label: 'Assistant head',
          required: false,
          minimumAge: 21,
          onChanged: (v) => setState(() => _assistantId = v),
        ),
        EnumField<Weekday>(
          label: 'Meeting day',
          values: Weekday.values,
          value: _day,
          labelOf: (v) => v.label,
          onChanged: (v) => setState(() => _day = v),
        ),
        EnumField<String>(
          label: 'Meeting time',
          values: times.contains(_time) ? times : [_time, ...times],
          value: _time,
          labelOf: (v) => v,
          onChanged: (v) => setState(() => _time = v),
        ),
        PlainTextField(
          label: 'Notes',
          controller: _notes,
          hint: 'Anything the team should know',
          maxLines: 2,
        ),
      ],
      onSubmit: () async {
        final repo = ref.read(repositoryProvider);
        await repo.setDepartmentLeadership(
          widget.department.id,
          headId: _headId,
          assistantHeadId: _assistantId,
        );
        await repo.updateDepartment(
          widget.department.id,
          meetingDay: _day,
          meetingTime: _time,
          notes: _notes.text.trim(),
        );
      },
    );
  }
}

/* ------------------------------------------------------------ leadership */

/// Appoints someone to a post — branch pastor, department head or group leader.
///
/// One form for all of them because the question is the same shape: pick the
/// kind of post, pick which branch/department/group, pick the person. The
/// alternative was three near-identical dialogs and a menu to choose between
/// them, which is more clicks to reach the same place.
///
/// The member list is filtered to the chosen scope's own branch, because that is
/// the rule the repository enforces — offering names it will silently reject
/// would make the form look broken.
Future<void> showLeadershipForm(
  BuildContext context, {
  LeadershipRole? role,
  String? memberId,
}) =>
    showDialog<void>(
      context: context,
      builder: (_) => _LeadershipForm(role: role, memberId: memberId),
    );

class _LeadershipForm extends ConsumerStatefulWidget {
  const _LeadershipForm({this.role, this.memberId});

  /// Preselected when appointing from a specific row.
  final LeadershipRole? role;
  final String? memberId;

  @override
  ConsumerState<_LeadershipForm> createState() => _LeadershipFormState();
}

class _LeadershipFormState extends ConsumerState<_LeadershipForm> {
  late LeadershipRole _role = widget.role ?? LeadershipRole.departmentHead;
  String? _scopeId;
  String? _memberId;

  @override
  void initState() {
    super.initState();
    _memberId = widget.memberId;
  }

  /// The branch, department or group the chosen post belongs to.
  List<({String id, String name, String branchId})> get _scopes {
    switch (_role) {
      case LeadershipRole.branchPastor:
      case LeadershipRole.assistantPastor:
        return [
          for (final b in ref.watch(branchesProvider))
            (id: b.id, name: b.name, branchId: b.id),
        ];
      case LeadershipRole.departmentHead:
      case LeadershipRole.assistantDepartmentHead:
        return [
          for (final d in ref.watch(departmentsProvider))
            (
              id: d.id,
              name: '${ref.watch(departmentNameProvider(d.id))}'
                  ' · ${ref.watch(branchCodeProvider(d.branchId))}',
              branchId: d.branchId,
            ),
        ];
      case LeadershipRole.groupLeader:
        return [
          for (final g in ref.watch(smallGroupsProvider))
            (
              id: g.id,
              name: '${g.name} · ${ref.watch(branchCodeProvider(g.branchId))}',
              branchId: g.branchId,
            ),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final scopes = _scopes;
    final scope = scopes.where((s) => s.id == _scopeId).firstOrNull;

    return FormDialog(
      title: 'Appoint a leader',
      description:
          'Leadership is held on the branch, department or group itself, so this '
          'updates that record — there is no separate list to keep in step.',
      submitLabel: 'Appoint',
      successMessage: _memberId == null
          ? 'Leadership updated.'
          : '${ref.read(memberNameProvider(_memberId))} is now'
              ' ${_role.label.toLowerCase()}.',
      fields: [
        EnumField<LeadershipRole>(
          label: 'Post',
          values: LeadershipRole.values,
          value: _role,
          labelOf: (v) => '${v.label} — ${v.description}',
          onChanged: (v) => setState(() {
            _role = v;
            // The scope list changes entirely with the post, so a stale
            // selection would point at the wrong kind of record.
            _scopeId = null;
            _memberId = null;
          }),
        ),
        LabelledField(
          label: switch (_role) {
            LeadershipRole.branchPastor ||
            LeadershipRole.assistantPastor =>
              'Branch',
            LeadershipRole.departmentHead ||
            LeadershipRole.assistantDepartmentHead =>
              'Department',
            LeadershipRole.groupLeader => 'Group',
          },
          child: DropdownButtonFormField<String>(
            initialValue: _scopeId,
            isExpanded: true,
            hint: Text(scopes.isEmpty
                ? 'Nothing to lead yet — create one first'
                : 'Choose one'),
            items: [
              for (final s in scopes)
                DropdownMenuItem(value: s.id, child: Text(s.name)),
            ],
            onChanged: scopes.isEmpty
                ? null
                : (v) => setState(() {
                      _scopeId = v;
                      _memberId = null;
                    }),
            validator: (v) => v == null ? 'Choose one' : null,
          ),
        ),
        // Only members of that branch, matching what the repository accepts.
        MemberField(
          branchId: scope?.branchId,
          value: _memberId,
          label: 'Leader',
          minimumAge: _role.isPastoral ? 21 : 16,
          onChanged: (v) => setState(() => _memberId = v),
        ),
      ],
      onSubmit: () async {
        final repo = ref.read(repositoryProvider);
        final id = _scopeId!;

        switch (_role) {
          case LeadershipRole.branchPastor:
            await repo.setBranchLeadership(id, pastorId: _memberId);
          case LeadershipRole.assistantPastor:
            await repo.setBranchLeadership(id, assistantPastorId: _memberId);
          case LeadershipRole.departmentHead:
            await repo.setDepartmentLeadership(id, headId: _memberId);
          case LeadershipRole.assistantDepartmentHead:
            await repo.setDepartmentLeadership(id, assistantHeadId: _memberId);
          case LeadershipRole.groupLeader:
            await repo.setGroupLeader(id, _memberId);
        }
      },
    );
  }
}
