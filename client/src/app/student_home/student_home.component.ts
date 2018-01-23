import { Component, OnInit } from '@angular/core';

import { Week } from '../_models/week';
import { User } from '../_models/index';
import { StudyHoursService } from '../_services/index';

@Component({
  moduleId: module.id,
  templateUrl: 'student_home.component.html'
})

export class StudentHomeComponent implements OnInit {
  currentUser: User;
  studyWeek: Week;

  constructor(private studyHoursService: StudyHoursService) {
    this.currentUser = JSON.parse(localStorage.getItem('currentUser'));
  }

  ngOnInit() {
    this.loadStudentDetails();
  }

  private loadStudentDetails() {
    this.studyHoursService.getStudyHoursForStudent(this.currentUser.id).then(
      studyWeek => {
        this.studyWeek = studyWeek;
      }
    );
  }
}
