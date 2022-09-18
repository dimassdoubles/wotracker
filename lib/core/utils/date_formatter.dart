List<String> months = [
  "Januari",
  "Februari",
  "Maret",
  "April",
  "Mei",
  "Juni",
  "Juli",
  "Agustus",
  "September",
  "Oktober",
  "November",
  "Desember",
];

String dateFormatter(DateTime date) {
  return "${date.day} ${months[date.month - 1]}";
}
