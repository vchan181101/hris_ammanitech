class CurrencyFormatter {
  static String formatIdr(double amount) {
    final int val = amount.toInt();
    final String str = val.toString();
    final StringBuffer buffer = StringBuffer();
    int count = 0;

    for (int i = str.length - 1; i >= 0; i--) {
      count++;
      buffer.write(str[i]);
      if (count % 3 == 0 && i != 0) {
        buffer.write('.');
      }
    }

    final String reversed = buffer.toString().split('').reversed.join('');
    return 'Rp $reversed';
  }
}
