import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { User } from '../_models/index';
import { UserService } from '../_services/index';

@Component({
  moduleId: module.id,
  templateUrl: 'professor_home.component.html'
})

export class ProfessorHomeComponent implements OnInit {
  currentUser: User;
  students: User[] = [];

  constructor(private userService: UserService, private router: Router) {
    this.currentUser = new User(JSON.parse(localStorage.getItem('currentUser')));
  }

  ngOnInit() {
    this.loadAllStudents();
  }

  loadUser(userId) {
    this.router.navigate(["/users/{{user.id}}"]);
  }

  private loadAllStudents() {
    this.userService.getStudents(this.currentUser).then(students => { this.students = students; });
  }
}
