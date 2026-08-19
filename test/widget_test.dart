import 'package:churchms/data/dashboard_data.dart';
import 'package:churchms/data/events_data.dart';
import 'package:churchms/data/finance_data.dart';
import 'package:churchms/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

/// Tests the dashboard and finance aggregates.
///
/// These used to check a bundled demo dataset. That dataset is gone — the church
/// enters its own records — so what matters now is that the functions computing
/// the charts behave correctly on whatever they are given, including nothing.
void main() {
  Member member({
    required String id,
    int age = 30,
    Gender gender = Gender.female,
    MemberStatus status = MemberStatus.active,
    bool baptised = true,
    List<String> departmentIds = const [],
    String? groupId,
  }) {
    final now = DateTime.now().toUtc();
    return Member(
      id: id,
      firstName: 'Test',
      lastName: id,
      email: '$id@example.com',
      phone: '+233 24 000 0000',
      gender: gender,
      dateOfBirth: DateTime.utc(now.year - age, 6, 15),
      maritalStatus: MaritalStatus.single,
      status: status,
      joinedAt: DateTime.utc(now.year - 1, 1, 1),
      address: const Address(line1: '1 Road', city: 'Accra', state: 'Greater Accra'),
      isBaptized: baptised,
      branchId: 'brn-0001',
      departmentIds: departmentIds,
      groupId: groupId,
    );
  }

  group('empty state', () {
    test('every aggregate copes with no data at all', () {
      expect(ageDistributionOf(const []).every((p) => p.value == 0), isTrue);
      expect(genderSplitOf(const []).every((p) => p.value == 0), isTrue);
      expect(growthFunnelOf(const []).every((p) => p.value == 0), isTrue);
      expect(givingByFundOf(const []), isEmpty);
      expect(totalGivingOf(const []), 0);
      expect(totalExpensesOf(const []), 0);
      expect(attendanceTrendFor(const []), isEmpty);
    });

    test('the finance trend still spans twelve months with no records', () {
      final trend = financeTrendOf(const []);
      expect(trend, hasLength(12));
      expect(trend.every((p) => p.value == 0), isTrue);
    });
  });

  group('demographics', () {
    test('age bands sum to the number of members', () {
      final members = [
        member(id: 'a', age: 8),
        member(id: 'b', age: 15),
        member(id: 'c', age: 25),
        member(id: 'd', age: 45),
        member(id: 'e', age: 70),
      ];

      final total =
          ageDistributionOf(members).fold<double>(0, (sum, p) => sum + p.value);
      expect(total, members.length);
    });

    test('a member lands in the right age band', () {
      final bands = ageDistributionOf([member(id: 'child', age: 8)]);
      final zeroToTwelve = bands.firstWhere((b) => b.label == '0–12');
      expect(zeroToTwelve.value, 1);
      expect(
        bands.where((b) => b.label != '0–12').every((b) => b.value == 0),
        isTrue,
      );
    });

    test('gender split counts both', () {
      final split = genderSplitOf([
        member(id: 'f1', gender: Gender.female),
        member(id: 'f2', gender: Gender.female),
        member(id: 'm1', gender: Gender.male),
      ]);
      expect(split.firstWhere((p) => p.label == 'Female').value, 2);
      expect(split.firstWhere((p) => p.label == 'Male').value, 1);
    });
  });

  group('growth funnel', () {
    test('it narrows monotonically', () {
      final members = [
        member(id: 'visitor', status: MemberStatus.visitor, baptised: false),
        member(id: 'returned', baptised: false),
        member(id: 'baptised'),
        member(id: 'serving', departmentIds: const ['dpt-worship']),
        member(
          id: 'grouped',
          departmentIds: const ['dpt-worship'],
          groupId: 'grp-0001',
        ),
      ];

      final steps = growthFunnelOf(members);
      for (var i = 1; i < steps.length; i++) {
        expect(
          steps[i].value,
          lessThanOrEqualTo(steps[i - 1].value),
          reason: '${steps[i].label} must not exceed ${steps[i - 1].label}',
        );
      }
    });

    test('each stage is a subset of the one above', () {
      final steps = growthFunnelOf([
        member(id: 'visitor', status: MemberStatus.visitor, baptised: false),
        member(
          id: 'full',
          departmentIds: const ['dpt-worship'],
          groupId: 'grp-0001',
        ),
      ]);

      expect(steps.first.value, 2, reason: 'both are first-time visitors');
      expect(steps.last.value, 1, reason: 'only one reaches a small group');
    });
  });

  group('giving', () {
    Donation gift(double amount, GivingFund fund, DateTime date) => Donation(
          id: 'don-$amount-${fund.name}',
          donorName: 'Test',
          amount: amount,
          fund: fund,
          method: PaymentMethod.cash,
          date: date,
          reference: 'TXN',
          isRecurring: false,
          branchId: 'brn-0001',
        );

    test('totals and fund split add up', () {
      final now = DateTime.now().toUtc();
      final gifts = [
        gift(1000, GivingFund.tithe, now),
        gift(500, GivingFund.tithe, now),
        gift(250, GivingFund.building, now),
      ];

      expect(totalGivingOf(gifts), 1750);

      final byFund = givingByFundOf(gifts);
      expect(byFund.first.label, GivingFund.tithe.label,
          reason: 'the largest fund leads');
      expect(byFund.first.value, 1500);
    });

    test('the trend places a gift in its own month', () {
      final now = DateTime.utc(2026, 8, 15);
      final trend = financeTrendOf(
        [gift(1000, GivingFund.tithe, DateTime.utc(2026, 8, 3))],
        now: now,
      );

      expect(trend.last.label, 'Aug');
      expect(trend.last.value, 1000);
      expect(
        trend.take(11).every((p) => p.value == 0),
        isTrue,
        reason: 'earlier months had no giving',
      );
    });
  });

  group('attendance trend', () {
    test('records sharing a date are summed across branches', () {
      final date = DateTime.utc(2026, 8, 16);
      AttendanceRecord record(String id, String branch, int adults) =>
          AttendanceRecord(
            id: id,
            date: date,
            serviceName: 'First Service',
            branchId: branch,
            adults: adults,
            children: 0,
            visitors: 0,
            online: 5,
          );

      final trend = attendanceTrendFor([
        record('a', 'brn-0001', 100),
        record('b', 'brn-0002', 50),
      ]);

      expect(trend, hasLength(1));
      expect(trend.single.value, 150, reason: 'in-person is summed');
      expect(trend.single.compare, 10, reason: 'online is summed');
    });
  });
}
