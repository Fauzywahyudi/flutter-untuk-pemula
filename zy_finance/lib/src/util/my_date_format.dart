class MyDateFormat {
  String myFullFormatDate(DateTime value) {
    return '${value.day} ${fullMonthName(value.month)} ${value.year}';
  }

  String myFullMonthYear(DateTime value) {
    return '${fullMonthName(value.month)} ${value.year}';
  }

  String fullMonthName(int value) {
    switch (value) {
      case 1:
        return 'Januari';
        break;
      case 2:
        return 'Februari';
        break;
      case 3:
        return 'Maret';
        break;
      case 4:
        return 'April';
        break;
      case 5:
        return 'Mei';
        break;
      case 6:
        return 'Juni';
        break;
      case 7:
        return 'Juli';
        break;
      case 8:
        return 'Agustus';
        break;
      case 9:
        return 'September';
        break;
      case 10:
        return 'Oktober';
        break;
      case 11:
        return 'November';
        break;
      case 12:
        return 'Desember';
        break;
      default:
        return 'Not valid';
        break;
    }
  }

  String monthName(DateTime date) {
    switch (date.month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'Mei';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Agu';
      case 9:
        return 'Sep';
      case 10:
        return 'Okt';
      case 11:
        return 'Nov';
      case 12:
        return 'Des';
      default:
        return 'Jan';
    }
  }

  String myMonthYear(DateTime date) {
    return monthName(date) + ' ' + date.year.toString();
  }

  String myFullDateTime(DateTime date) {
    return '${date.hour}:${date.minute < 10 ? '0' + date.minute.toString() : date.minute} - ${date.day} ${monthName(date)} ${date.year}';
  }

  String myDifferenceDate(Duration difference) {
    if (difference.inMinutes <= 1) return 'Just Now';
    if (difference.inMinutes < 60) return '${difference.inMinutes} minutes ago';
    if (difference.inHours <= 1) return '${difference.inHours} hour ago';
    if (difference.inHours < 24) return '${difference.inHours} hours ago';
    if (difference.inDays <= 1) return '${difference.inDays} day ago';
    if (difference.inDays < 30) return '${difference.inDays} days ago';
    if (difference.inDays <= 31) return '1 month ago';
    if (difference.inDays > 31) {
      int month = 0;
      for (int i = 1; i < difference.inDays; i + 30) {
        month++;
      }
      return '$month months ago';
    }
    return '-';
  }
}
