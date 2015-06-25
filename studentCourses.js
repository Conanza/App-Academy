function Student(fname, lname) {
  this.fname = fname;
  this.lname = lname;
  this.courses = [];
}

Student.prototype.name = function () {
  return (this.fname + " " + this.lname);
}

Student.prototype.allCourses = function () {
  return this.courses;
}

Student.prototype.enroll = function (course) {
  var enrolled = false;
  for (i = 0; i < this.courses.length; i++) {
    if (this.courses[i].name === course.name) {
      enrolled = true;
    }
  }

  if (!enrolled) {
    this.courses.push(course);
    course.addStudent(this);
  }
}

Student.prototype.courseLoad = function () {
  var courses = this.courses;
  var listOfDepartments = {};
  for(var i = 0; i < courses.length; i++){
    listOfDepartments[courses[i].dept] = listOfDepartments[courses[i].dept] || 0;
    if (listOfDepartments[courses[i].dept] === undefined){
      listOfDepartments[courses[i].dept] = courses[i].credits;
    }
    else {
      listOfDepartments[courses[i].dept] += courses[i].credits;
    }
  }
  return listOfDepartments;
}



function Course(name, dept, credits) {
  this.name = name;
  this.dept = dept;
  this.credits = credits;
  this.students = [];
}


Course.prototype.addStudent = function (student) {
  this.students.push(student);
  student.enroll(this);
}

Course.prototype.allStudents = function() {
  var studentsArr = this.students;
  var studentNames = [];
  for (var i = 0;  i < studentsArr.length; i++){
    studentNames.push(studentsArr[i].name);
  }
  return studentNames;
}


var conan = new Student("conan", "tzou");
var simon = new Student("simon", "hsieh");

console.log(conan.name());
console.log(simon.name());
console.log(conan.allCourses());

var math = new Course("calc ab", "math", 5);
var math2 = new Course("trig", "math", 3);
conan.enroll(math);
conan.enroll(math2);

console.log(conan.allCourses());
// console.log(math.allStudents());
console.log(conan.courseLoad());
