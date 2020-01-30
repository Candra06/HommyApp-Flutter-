class Validasi {
  String validasiPassword(String value){
    if (value.length < 4 && value.isEmpty) {
      return 'Password minimal 4 karakter!';
    }
    return null;
  }

  String validasiEmail(String value){
    if (!value.contains('@') && value.isEmpty) {
      return 'Email tidak valid!';
    }
    return null;
  }

  String validasiIsi(String value){
    if (value.isEmpty) {
      return 'Inputan tidak boleh kosong';
    }
    return null;
  }
}