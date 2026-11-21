import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/constants/app_colors.dart';

void main() {
  test('AppColors verify teal LifeOS orb color', () {
    expect(AppColors.tealOrb.value, 0xFF00E5FF);
  });
}
