class Sequence {
  List<int> _sequence = [];
  final int _sequenceSize;
  final int _maxValueInSequence;

  int currentIndex = 0;

  Sequence(this._sequenceSize, this._maxValueInSequence) {
    generateSequence();
  }

  void generateSequence() {
    if (!canGenerateSequence()) return;

    _sequence = generateOrderedSequence(_maxValueInSequence);
    _sequence.shuffle();

    if (_sequence.length > _sequenceSize) {
      _sequence = _sequence.sublist(0, _sequenceSize);
    }
  }

  bool isFirstValueInSequence() {
    return currentIndex == 0;
  }

  bool isLastValueInSequence() {
    return currentIndex == _sequence.length - 1;
  }

  int getCurrentValueInSequence() {
    return _sequence[currentIndex];
  }

  void goToNextValueInSequence() {
    currentIndex++;
  }

  void goToPreviousValueInSequence() {
    currentIndex--;
  }

  bool canGenerateSequence() {
    return _maxValueInSequence > 0 && !isSequenceGenerated();
  }

  bool isSequenceGenerated() {
    return _sequence.isNotEmpty;
  }

  List<int> generateOrderedSequence(int sequenceSize) {
    List<int> orderedSequence = [];

    for (int i = 0; i < sequenceSize; i++) {
      orderedSequence.add(i);
    }

    return orderedSequence;
  }
}
