import { Component, OnInit } from '@angular/core';

import { User } from '../_models/index';
import { UserService } from '../_services/index';

@Component({
  moduleId: module.id,
  templateUrl: 'professor_home.component.html'
})

export class ProfessorHomeComponent implements OnInit {
  currentUser: User;
  students: User[] = [];

  constructor(private userService: UserService) {
    this.currentUser = new User(JSON.parse(localStorage.getItem('currentUser')));
  }

  ngOnInit() {
    this.loadAllStudents();
  }

  private loadAllStudents() {
    this.userService.getStudents(this.currentUser).then(students => { this.students = students; });
  }
}
