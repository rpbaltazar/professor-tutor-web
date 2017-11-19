import { Injectable } from '@angular/core';
import { Router, CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { User } from '../_models/index';

@Injectable()
export class AuthGuard implements CanActivate {

  constructor(private router: Router) { }

  canActivate(route: ActivatedRouteSnapshot, state: RouterStateSnapshot) {
    let userJSON = localStorage.getItem('currentUser');
    if(userJSON) {
      let currentUser = new User(JSON.parse(userJSON));

      if (currentUser) {
        // logged in so return true
        if (currentUser.isProfessor()) {
          this.router.navigate(['/my-students']);
        }
        else if (currentUser.isStudent()) {
          this.router.navigate(['/my-schedule']);
        }

        return true;
      }
    }
    else {
      // not logged in so redirect to login page with the return url
      this.router.navigate(['/login'], { queryParams: { returnUrl: state.url }});
      return false;
    }
  }
}
