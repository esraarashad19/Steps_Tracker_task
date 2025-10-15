String getUserInitials(String name) {
  if (name.trim().isEmpty) return "";

  final parts = name.trim().split(RegExp(r"\s+")); // split by spaces
  final first = parts.isNotEmpty ? parts.first[0].toUpperCase() : "";
  final last = parts.length > 1 ? parts.last[0].toUpperCase() : "";

  return "$first$last";
}