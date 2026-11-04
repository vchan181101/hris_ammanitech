import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../theme/app_colors.dart';
import 'services/attendance_history_service.dart';

class EssAttendanceTab extends StatefulWidget {
  final UserModel user;

  const EssAttendanceTab({super.key, required this.user});

  @override
  State<EssAttendanceTab> createState() => _EssAttendanceTabState();
}

class _EssAttendanceTabState extends State<EssAttendanceTab> {
  String _selectedFilter = 'Semua';
  String _selectedYear = 'Pilih Tahun 2026';
  String _selectedMonth = 'Semua Bulan';

  final AttendanceHistoryService _historyService = AttendanceHistoryService();

  @override
  void initState() {
    super.initState();
    _historyService.addListener(_onServiceUpdate);
  }

  @override
  void dispose() {
    _historyService.removeListener(_onServiceUpdate);
    super.dispose();
  }

  void _onServiceUpdate() {
    if (mounted) {
      setState(() {});
    }
  }

  void _showDownloadDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.file_download_outlined, color: Color(0xFF1D4ED8)),
            SizedBox(width: 8),
            Text('Download Laporan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih format file laporan riwayat presensi yang ingin diunduh:',
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.table_chart_rounded, color: Color(0xFF15803D)),
              ),
              title: const Text('Export Excel (.xlsx)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              subtitle: const Text('Format spreadsheet data lengkap rekap kehadiran tahunan', style: TextStyle(fontSize: 11)),
              onTap: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Berhasil mengunduh: Rekap_Presensi_Tahunan_2026.xlsx'),
                    backgroundColor: Color(0xFF15803D),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEE2E2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.picture_as_pdf_rounded, color: Color(0xFFB91C1C)),
              ),
              title: const Text('Export PDF Resmi (.pdf)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              subtitle: const Text('Dokumen resmi bertanda tangan digital HRD', style: TextStyle(fontSize: 11)),
              onTap: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Berhasil mengunduh: Laporan_Presensi_Resmi_2026.pdf'),
                    backgroundColor: Color(0xFF1D4ED8),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
        ],
      ),
    );
  }

  void _showYearPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih Tahun Presensi',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...['Pilih Tahun 2026', 'Pilih Tahun 2025', 'Pilih Tahun 2024'].map(
              (year) => ListTile(
                title: Text(year, style: const TextStyle(fontWeight: FontWeight.w600)),
                trailing: _selectedYear == year
                    ? const Icon(Icons.check_circle_rounded, color: Color(0xFF1D4ED8))
                    : null,
                onTap: () {
                  setState(() => _selectedYear = year);
                  Navigator.pop(ctx);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final allRecords = _historyService.records;
    final filteredRecords = allRecords.where((item) {
      if (_selectedFilter == 'Semua') return true;
      if (_selectedFilter == 'Tepat Waktu') {
        return item.status.contains('Tepat Waktu') || item.status.contains('Hadir');
      }
      if (_selectedFilter == 'Terlambat') {
        return item.status.contains('Terlambat');
      }
      if (_selectedFilter == 'Izin / Sakit/Cuti') {
        return item.status.contains('Izin') || item.status.contains('Sakit') || item.status.contains('Cuti');
      }
      if (_selectedFilter == 'Tanpa Keterangan') {
        return item.status.contains('Alpha') || item.status.contains('Mangkir') || item.status.contains('Tanpa');
      }
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Riwayat Presensi Tahunan',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF0F1E36),
        elevation: 0,
        actions: [
          // Tombol 1: Pilih Tahun 2026
          GestureDetector(
            onTap: _showYearPicker,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF162A45),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white24, width: 0.8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.calendar_today_outlined, color: Colors.white, size: 12),
                  const SizedBox(width: 4),
                  Text(
                    _selectedYear,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 6),

          // Tombol 2: Download Excel/PDF
          GestureDetector(
            onTap: _showDownloadDialog,
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 12, 10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF1D4ED8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.file_download_outlined, color: Colors.white, size: 13),
                  SizedBox(width: 4),
                  Text(
                    'Download Excel/PDF',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= 1. FILTER SECTION (PILIH BULAN & CHIPS TENGAH) =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Pilih Bulan:',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          DropdownButton<String>(
                            value: _selectedMonth,
                            isDense: true,
                            underline: const SizedBox(),
                            style: const TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1D4ED8),
                            ),
                            items: const [
                              DropdownMenuItem(value: 'Semua Bulan', child: Text('Semua Bulan')),
                              DropdownMenuItem(value: 'Maret 2026', child: Text('Maret 2026')),
                              DropdownMenuItem(value: 'Februari 2026', child: Text('Februari 2026')),
                              DropdownMenuItem(value: 'Januari 2026', child: Text('Januari 2026')),
                            ],
                            onChanged: (val) {
                              if (val != null) setState(() => _selectedMonth = val);
                            },
                          ),
                        ],
                      ),
                      DropdownButton<String>(
                        value: _selectedYear,
                        isDense: true,
                        underline: const SizedBox(),
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        items: const [
                          DropdownMenuItem(value: 'Pilih Tahun 2026', child: Text('Pilih Tahun 2026')),
                          DropdownMenuItem(value: 'Pilih Tahun 2025', child: Text('Pilih Tahun 2025')),
                          DropdownMenuItem(value: 'Pilih Tahun 2024', child: Text('Pilih Tahun 2024')),
                        ],
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedYear = val);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // REVISI #2: Filter Chips Diposisikan di Tengah (Center-Aligned)
                  Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildFilterBadge(
                            title: 'Semua',
                            count: _historyService.totalKehadiran,
                            activeColor: const Color(0xFF1D4ED8),
                            bgOutlined: Colors.white,
                            borderOutlined: const Color(0xFFCBD5E1),
                            textOutlined: const Color(0xFF334155),
                          ),
                          const SizedBox(width: 8),
                          _buildFilterBadge(
                            title: 'Tepat Waktu',
                            count: _historyService.tepatWaktu,
                            activeColor: const Color(0xFF15803D),
                            bgOutlined: const Color(0xFFE8F5E9),
                            borderOutlined: const Color(0xFF81C784),
                            textOutlined: const Color(0xFF2E7D32),
                          ),
                          const SizedBox(width: 8),
                          _buildFilterBadge(
                            title: 'Terlambat',
                            count: _historyService.terlambat,
                            activeColor: const Color(0xFFEA580C),
                            bgOutlined: const Color(0xFFFFF3E0),
                            borderOutlined: const Color(0xFFFFB74D),
                            textOutlined: const Color(0xFFE65100),
                          ),
                          const SizedBox(width: 8),
                          _buildFilterBadge(
                            title: 'Izin / Sakit/Cuti',
                            count: _historyService.izinSakit,
                            activeColor: const Color(0xFF0284C7),
                            bgOutlined: const Color(0xFFE1F5FE),
                            borderOutlined: const Color(0xFF81D4FA),
                            textOutlined: const Color(0xFF0277BD),
                          ),
                          const SizedBox(width: 8),
                          _buildFilterBadge(
                            title: 'Tanpa Keterangan',
                            count: _historyService.tanpaKeterangan,
                            activeColor: const Color(0xFF64748B),
                            bgOutlined: const Color(0xFFF1F5F9),
                            borderOutlined: const Color(0xFFCBD5E1),
                            textOutlined: const Color(0xFF64748B),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ================= 2. METRIC SUMMARY CARDS =================
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 720;
                if (isWide) {
                  return Row(
                    children: [
                      Expanded(
                        child: _buildMetricCard(
                          icon: Icons.people_outline_rounded,
                          iconColor: const Color(0xFF334155),
                          title: 'Total Kehadiran',
                          value: '${_historyService.totalKehadiran} hari',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildMetricCard(
                          icon: Icons.timer_outlined,
                          iconColor: const Color(0xFF16A34A),
                          title: 'Tepat Waktu',
                          value: '${_historyService.tepatWaktu} hari',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildMetricCard(
                          icon: Icons.access_time_rounded,
                          iconColor: const Color(0xFFEA580C),
                          title: 'Terlambat',
                          value: '${_historyService.terlambat} hari',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildMetricCard(
                          icon: Icons.notifications_off_outlined,
                          iconColor: const Color(0xFF0284C7),
                          title: 'Izin / Sakit/Cuti',
                          value: '${_historyService.izinSakit} hari',
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildMetricCard(
                              icon: Icons.people_outline_rounded,
                              iconColor: const Color(0xFF334155),
                              title: 'Total Kehadiran',
                              value: '${_historyService.totalKehadiran} hari',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildMetricCard(
                              icon: Icons.timer_outlined,
                              iconColor: const Color(0xFF16A34A),
                              title: 'Tepat Waktu',
                              value: '${_historyService.tepatWaktu} hari',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _buildMetricCard(
                              icon: Icons.access_time_rounded,
                              iconColor: const Color(0xFFEA580C),
                              title: 'Terlambat',
                              value: '${_historyService.terlambat} hari',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildMetricCard(
                              icon: Icons.notifications_off_outlined,
                              iconColor: const Color(0xFF0284C7),
                              title: 'Izin / Sakit/Cuti',
                              value: '${_historyService.izinSakit} hari',
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              },
            ),

            const SizedBox(height: 16),

            // ================= 3. DATA TABLE LIST (REVISI #1: SEJAJAR KANAN-KIRI DENGAN KARTU SUMMARY) =================
            LayoutBuilder(
              builder: (context, constraints) {
                // Lebar tabel menyesuaikan 100% lebar container kartu di atasnya jika >= 1020px
                final tableWidth = math.max(constraints.maxWidth, 1020.0);

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: tableWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // A. Table Header Bar (Sejajar sempurna dengan ruas kolom di atasnya)
                        Container(
                          width: tableWidth,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: const Row(
                            children: [
                              Expanded(
                                flex: 22,
                                child: Text(
                                  'HARI / TANGGAL',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF475569),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 14,
                                child: Text(
                                  'STATUS',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF475569),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 17,
                                child: Text(
                                  'MASUK',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF475569),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 17,
                                child: Text(
                                  'KELUAR',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF475569),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 18,
                                child: Text(
                                  'VERIFIKASI',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF475569),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 18,
                                child: Text(
                                  'DURASI KERJA',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF475569),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 8),

                        // B. Baris Data (Row Rows)
                        ...filteredRecords.map((record) => _buildTableRow(record, tableWidth)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: iconColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF64748B),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBadge({
    required String title,
    required int count,
    required Color activeColor,
    required Color bgOutlined,
    required Color borderOutlined,
    required Color textOutlined,
  }) {
    final bool isSelected = _selectedFilter == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = title;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? activeColor : bgOutlined,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? activeColor : borderOutlined,
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: activeColor.withValues(alpha: 0.25),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected) ...[
              const Icon(Icons.check_rounded, color: Colors.white, size: 13),
              const SizedBox(width: 4),
            ],
            Text(
              '$title ($count)',
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: isSelected ? Colors.white : textOutlined,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // REVISI #3: Kolom Verifikasi Lengkap Sesuai Spesifikasi (Hadir, Terlambat, Pulang Cepat, Sakit, Izin, Cuti, Alpha)
  Widget _buildVerificationContent(AttendanceHistoryRecord record) {
    final status = record.status.trim();

    String emojiUtama;
    String symbolKarakter;
    String altEmoji;
    String labelVerifikasi;
    String maknaVisual;
    Color accentColor;

    if (status.contains('Tepat Waktu') || status.contains('Hadir')) {
      emojiUtama = '🟢';
      symbolKarakter = '[✓]';
      altEmoji = '✅';
      labelVerifikasi = 'Face Verified';
      maknaVisual = 'Kondisi aman, terverifikasi, tepat sasaran';
      accentColor = const Color(0xFF16A34A);
    } else if (status.contains('Terlambat')) {
      emojiUtama = '🟡';
      symbolKarakter = '[!]';
      altEmoji = '⚠️';
      labelVerifikasi = 'Face Verified';
      maknaVisual = 'Peringatan: Keterlambatan jam masuk';
      accentColor = const Color(0xFFEA580C);
    } else if (status.contains('Pulang Cepat') || status.contains('Early')) {
      emojiUtama = '🏃';
      symbolKarakter = '[<]';
      altEmoji = '🚪';
      labelVerifikasi = 'Early Leave';
      maknaVisual = 'Meninggalkan lokasi mendahului jadwal';
      accentColor = const Color(0xFFD97706);
    } else if (status.contains('Sakit')) {
      emojiUtama = '🤒';
      symbolKarakter = '[+]';
      altEmoji = '🏥';
      labelVerifikasi = 'Surat Dokter';
      maknaVisual = 'Kondisi kesehatan/medis terlampir';
      accentColor = const Color(0xFF0284C7);
    } else if (status.contains('Izin')) {
      emojiUtama = '📝';
      symbolKarakter = '[i]';
      altEmoji = '📩';
      labelVerifikasi = 'Permohonan Izin';
      maknaVisual = 'Dokumen/surat permohonan resmi disetujui';
      accentColor = const Color(0xFF2563EB);
    } else if (status.contains('Cuti')) {
      emojiUtama = '🏖️';
      symbolKarakter = '[C]';
      altEmoji = '🌴';
      labelVerifikasi = 'Cuti Tahunan';
      maknaVisual = 'Masa istirahat/liburan resmi';
      accentColor = const Color(0xFF0D9488);
    } else {
      // Alpha / Mangkir / Tanpa Keterangan
      emojiUtama = '🔴';
      symbolKarakter = '[X]';
      altEmoji = '❌';
      labelVerifikasi = 'Alpha / Mangkir';
      maknaVisual = 'Ketidakhadiran tanpa keterangan resmi';
      accentColor = const Color(0xFFDC2626);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$emojiUtama $symbolKarakter', style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold)),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                '$altEmoji $labelVerifikasi',
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          maknaVisual,
          style: const TextStyle(
            fontSize: 9,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w500,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  // REVISI #1: Baris Tabel Menggunakan Expanded Ratios Sejajar dengan Header & Ringkasan Metrik
  Widget _buildTableRow(AttendanceHistoryRecord record, double tableWidth) {
    Color statusBgColor;
    Color statusTextColor;

    if (record.status.contains('Tepat Waktu') || record.status.contains('Hadir')) {
      statusBgColor = const Color(0xFFE8F5E9);
      statusTextColor = const Color(0xFF2E7D32);
    } else if (record.status.contains('Terlambat')) {
      statusBgColor = const Color(0xFFFFF3E0);
      statusTextColor = const Color(0xFFE65100);
    } else if (record.status.contains('Pulang Cepat')) {
      statusBgColor = const Color(0xFFFEF3C7);
      statusTextColor = const Color(0xFFB45309);
    } else if (record.status.contains('Sakit')) {
      statusBgColor = const Color(0xFFE0F2FE);
      statusTextColor = const Color(0xFF0369A1);
    } else if (record.status.contains('Izin')) {
      statusBgColor = const Color(0xFFEFF6FF);
      statusTextColor = const Color(0xFF1D4ED8);
    } else if (record.status.contains('Cuti')) {
      statusBgColor = const Color(0xFFCCFBF1);
      statusTextColor = const Color(0xFF0F766E);
    } else {
      statusBgColor = const Color(0xFFFFEBEE);
      statusTextColor = const Color(0xFFC62828);
    }

    return Container(
      width: tableWidth,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Kolom HARI / TANGGAL (flex: 22)
          Expanded(
            flex: 22,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  record.date,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(Icons.login_rounded, size: 12, color: Color(0xFF334155)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Masuk: ${record.inTime}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF334155),
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 12, color: Color(0xFF64748B)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        record.location,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF64748B),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 2. Kolom STATUS (flex: 14)
          Expanded(
            flex: 14,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  record.status,
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.bold,
                    color: statusTextColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),

          // 3. Kolom MASUK (flex: 17)
          Expanded(
            flex: 17,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(Icons.login_rounded, size: 13, color: Color(0xFF0F4C81)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Jam: ${record.inTime}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 12, color: Color(0xFF64748B)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        record.location,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF64748B),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 4. Kolom KELUAR (flex: 17)
          Expanded(
            flex: 17,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(Icons.logout_rounded, size: 13, color: Color(0xFFDC2626)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Keluar: ${record.outTime}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFDC2626),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 12, color: Color(0xFF64748B)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        record.location,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF64748B),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 5. Kolom VERIFIKASI (flex: 18) - Menampilkan emoji, symbol & makna
          Expanded(
            flex: 18,
            child: _buildVerificationContent(record),
          ),

          // 6. Kolom DURASI KERJA (flex: 18)
          Expanded(
            flex: 18,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Badge Status
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    record.badgeDurasi,
                    style: TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                      color: statusTextColor,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                // Linear Progress Bar Biru
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: record.durationRatio,
                    minHeight: 5,
                    backgroundColor: const Color(0xFFE2E8F0),
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0F4C81)),
                  ),
                ),
                const SizedBox(height: 6),
                // Bottom row: Verifikasi status & Durasi Jam Mnt
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle_outline_rounded, size: 11, color: Color(0xFF64748B)),
                        SizedBox(width: 3),
                        Text(
                          'Verified',
                          style: TextStyle(fontSize: 9.5, color: Color(0xFF64748B)),
                        ),
                      ],
                    ),
                    Flexible(
                      child: Text(
                        'Durasi: ${record.duration}',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
