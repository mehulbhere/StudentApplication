class Student {
  final int? id;
  final String name;
  final double fees;
  final String academicYear;
  final String className;

  Student({
    this.id,
    required this.name,
    required this.fees,
    required this.academicYear,
    required this.className,
  });

  Map<String, dynamic> toMap() {
    print(
        "'id': '$id','name': '$name','fees': '$fees','academicYear': '$academicYear','className': '$className',");
    return {
      'id': id,
      'name': name,
      'fees': fees,
      'academicYear': academicYear,
      'className': className,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      fees: map['id'],
      academicYear: map['academicYear'],
      className: map['className'],
    );
  }
}
