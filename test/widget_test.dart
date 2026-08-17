import 'package:churchms/data/dashboard_data.dart';
import 'package:churchms/data/departments_data.dart';
import 'package:churchms/data/members_data.dart';
import 'package:churchms/data/operations_data.dart';
import 'package:churchms/data/seed.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('mock data integrity', () {
    test('seeded generation is deterministic', () {
      expect(Seed.intIn(42, 0, 100), Seed.intIn(42, 0, 100));
      expect(members.length, 240);
    });

    test('demographics agree with the directory', () {
      final byAge =
          ageDistributionOf(members).fold<double>(0, (sum, p) => sum + p.value);
      final byGender =
          genderSplitOf(members).fold<double>(0, (sum, p) => sum + p.value);
      expect(byAge, members.length.toDouble());
      expect(byGender, members.length.toDouble());
    });

    test('growth funnel narrows monotonically', () {
      final steps = growthFunnelOf(members);
      for (var i = 1; i < steps.length; i++) {
        expect(
          steps[i].value,
          lessThanOrEqualTo(steps[i - 1].value),
          reason: '${steps[i].label} must not exceed ${steps[i - 1].label}',
        );
      }
    });

    test('nobody joined before they were born', () {
      for (final m in members) {
        expect(
          m.joinedAt.isBefore(m.dateOfBirth),
          isFalse,
          reason: '${m.fullName} joined before their date of birth',
        );
        expect(m.ageAt(kDemoNow), greaterThan(0), reason: m.fullName);
      }
    });

    test('every member belongs to a real branch', () {
      final ids = branches.map((b) => b.id).toSet();
      for (final m in members) {
        expect(ids.contains(m.branchId), isTrue, reason: m.fullName);
      }
    });

    test('every branch has members and a pastor drawn from them', () {
      for (final b in branches) {
        final roll = members.where((m) => m.branchId == b.id).toList();
        expect(roll, isNotEmpty, reason: '${b.name} has no members');
        expect(
          roll.any((m) => m.id == b.pastorId),
          isTrue,
          reason: '${b.name} pastor is not one of its members',
        );
      }
    });

    test('department members come from the department\'s own branch', () {
      for (final d in departments) {
        for (final id in d.memberIds) {
          final m = memberById(id);
          expect(m, isNotNull);
          expect(
            m!.branchId,
            d.branchId,
            reason: '${m.fullName} is in a department at another branch',
          );
        }
      }
    });

    test('age-gated departments only contain eligible members', () {
      for (final d in departments) {
        final type = departmentTypeById(d.typeId);
        if (type?.ageRange == null) continue;
        for (final id in d.memberIds) {
          final age = memberById(id)!.ageAt(kDemoNow);
          expect(age, greaterThanOrEqualTo(type!.ageRange!.min));
          expect(age, lessThanOrEqualTo(type.ageRange!.max));
        }
      }
    });

    test('core departments run at every branch', () {
      for (final type in departmentTypes.where((t) => t.isCore)) {
        for (final b in branches) {
          final eligible = members.where((m) {
            if (m.branchId != b.id) return false;
            if (type.ageRange == null) return true;
            final age = m.ageAt(kDemoNow);
            return age >= type.ageRange!.min && age <= type.ageRange!.max;
          });
          if (eligible.isEmpty) continue; // nobody eligible: nothing to run
          expect(
            departments.any((d) => d.branchId == b.id && d.typeId == type.id),
            isTrue,
            reason: '${type.name} missing at ${b.name}',
          );
        }
      }
    });

    test('no past event is dated in the future', () {
      for (final u in staffUsers) {
        expect(u.lastActiveAt.isAfter(kDemoNow), isFalse, reason: u.name);
      }
      for (final c in careRequests) {
        expect(c.createdAt.isAfter(kDemoNow), isFalse, reason: c.id);
      }
    });
  });
}
