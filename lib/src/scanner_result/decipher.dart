class Decipher {
  // Substition cipher used to decrypt the text
  static final Map<String, String> _lookup = {
    'S': 'E',
    'G': 'O',
    'O': 'T',
    'I': 'H',
    'W': 'W',
    'D': 'L',
    'K': 'R',
    'L': 'S',
    'M': 'A',
    'E': 'M',
    'N': 'C',
    'C': 'F',
    'Q': 'U',
    'F': 'N',
    'R': 'G',
    'U': 'D',
    'P': 'I',
    'Y': 'Y',
    'H': 'P',
    'X': 'X',
    'V': 'V',
    'B': 'K',
    'A': 'B',
    'J': 'Q',
  };

  static String decipher(String message) {
    // For each letter within the message
    // Check if the letter is in the lookup table
    // If it is, replace it with the corresponding letter
    // otherwise leave it as is
    String result = "";
    for (int i = 0; i < message.length; i++) {
      String letter = message[i];
      String? decipheredLetter = _lookup[letter];
      if (decipheredLetter != null) {
        result += decipheredLetter;
      } else {
        result += letter;
      }
    }
    return result;
  }
}
