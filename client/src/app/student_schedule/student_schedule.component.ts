import { Component, OnInit, OnDestroy } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { User } from '../_models/index';
import { Week } from '../_models/week';
import { StudyHoursService } from '../_services/index';

@Component({
  moduleId: module.id,
  templateUrl: 'student_schedule.component.html'
})

export class Schedule implements OnInit, OnDestroy {
  student: User;
  studyWeek: Week;
  private sub: any;

  constructor(private studyHoursService: StudyHoursService, private route: ActivatedRoute) {
  }

  ngOnInit() {
    this.sub = this.route.params.subscribe(params => {
      this.student = new User({id: params['id']});
      this.loadStudentDetails();
    });
  }

  ngOnDestroy() {
    this.sub.unsubscribe();
  }

  private loadStudentDetails(){
    this.studyHoursService.getStudyHoursForStudent(this.student.id).then(
      studyWeek => {
        this.studyWeek = studyWeek;
      }
    );
  }
}
