import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule }    from '@angular/forms';
import { HttpModule } from '@angular/http';
import { BaseRequestOptions } from '@angular/http';
import { AppComponent } from './app.component';
import { AuthGuard } from './_guards/index';
import { AlertService, AuthenticationService, UserService, StudyHoursService } from './_services/index';
import { HomeComponent } from './home/index';
import { ProfessorHomeComponent } from './professor_home/index';
import { StudentHomeComponent } from './student_home/index';
import { Schedule } from './student_schedule/index';
import { LoginComponent } from './login/index';
import { routing }        from './app.routing';

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    HomeComponent,
    ProfessorHomeComponent,
    StudentHomeComponent,
    Schedule
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpModule,
    routing
  ],
  providers: [
    AuthGuard,
    AlertService,
    AuthenticationService,
    UserService,
    BaseRequestOptions,
    StudyHoursService
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
