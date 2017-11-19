import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule }    from '@angular/forms';
import { HttpModule } from '@angular/http';
import { BaseRequestOptions } from '@angular/http';
import { AppComponent } from './app.component';
import { routing }        from './app.routing';
import { AuthGuard } from './_guards/index';
import { AlertService, AuthenticationService, UserService } from './_services/index';
import { HomeComponent } from './home/index';
import { ProfessorHomeComponent } from './professor_home/index';
import { StudentHomeComponent } from './student_home/index';
import { LoginComponent } from './login/index';

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    HomeComponent,
    ProfessorHomeComponent,
    StudentHomeComponent
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
    BaseRequestOptions],
  bootstrap: [AppComponent]
})
export class AppModule { }
