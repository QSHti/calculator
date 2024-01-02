class CalculatorLogic {

  double _currentResult = 0.0;
  String _currentOperation = '';
  String _currentInput = '';
  List<String> _history = [];

  String get currentResult => _currentInput.isEmpty ? _currentResult.toString() : _currentInput;
  String get history => _history.join(" ");
  String get currentInput => _currentInput;



  void inputDigit(String digit) {
    if (digit == '.' && _currentInput.contains('.')) {
      return; // Prevent multiple dots
    }
    _currentInput += digit;
  }

  void inputOperation(String operation) {
    if (_currentInput.isNotEmpty) {
      // Convert the current input to a number and perform the pending operation if any
      double newOperand = double.tryParse(_currentInput) ?? 0;
      if (_currentOperation.isNotEmpty) {
        _currentResult = _performOperation(_currentResult, newOperand, _currentOperation);
      } else {
        _currentResult = newOperand;
      }
      _history.add(_currentInput + ' ' + operation); // Add the operand and operation to the history
      _currentInput = '';
      _currentOperation = operation;
    } else if (_currentOperation.isEmpty) {
      // If there's no pending operation, just set the current operation
      _currentOperation = operation;
      _history.add(_currentResult.toString() + ' ' + operation); // Add the current result and operation to the history
    }
  }

  void finalizeCalculation() {
    if (_currentOperation.isNotEmpty && _currentInput.isNotEmpty) {
      double operand2 = double.tryParse(_currentInput) ?? 0;
      _currentResult = _performOperation(_currentResult, operand2, _currentOperation);
      _history.add(_currentInput + ' = ' + _currentResult.toString()); // Add the full operation to the history
      _currentInput = ''; // Clear the current input
      _currentOperation = ''; // Clear the current operation
    }
  }


  void calculatePercentage() {
    if (_currentInput.isNotEmpty) {
      _currentResult = double.parse(_currentInput) / 100;
      _currentInput = _currentResult.toString();
      _history.add('%');
    }
  }

  void clear() {
    _currentResult = 0.0;
    _currentOperation = '';
    _currentInput = '';
    _history.clear();
  }

  void toggleSign() {
    if (_currentInput.isNotEmpty) {
      _currentInput = (_currentInput.startsWith('-') ? '' : '-') + _currentInput;
    } else if (_currentResult != 0.0) {
      _currentResult = -_currentResult;
      _currentInput = _currentResult.toString();
    }
  }

  double _performOperation(double operand1, double operand2, String operation) {
    switch (operation) {
      case '+':
        return operand1 + operand2;
      case '-':
        return operand1 - operand2;
      case '*':
        return operand1 * operand2;
      case '/':
        return operand2 != 0 ? operand1 / operand2 : 0;
      default:
        throw Exception('Unsupported operation: $operation');
    }
  }
}
