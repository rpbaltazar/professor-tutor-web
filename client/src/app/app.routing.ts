import { Routes, RouterModule } from '@angular/router';

import { LoginComponent } from './login/index';
import { HomeComponent } from './home/index';
import { StudentHomeComponent } from './student_home/index';
import { ProfessorHomeComponent } from './professor_home/index';
import { AuthGuard } from './_guards/index';

const appRoutes: Routes = [
  { path: '', component: HomeComponent, canActivate: [AuthGuard] },
  { path: 'login', component: LoginComponent },
  { path: 'my-students', component: ProfessorHomeComponent },
  { path: 'my-schedule', component: StudentHomeComponent },

  // otherwise redirect to home
  { path: '**', redirectTo: '' }
];

export const routing = RouterModule.forRoot(appRoutes);
