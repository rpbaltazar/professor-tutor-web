import { Injectable } from '@angular/core';
import { Router, CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { User } from '../_models/index';

@Injectable()
export class AuthGuard implements CanActivate {

  constructor(private router: Router) { }

  canActivate(route: ActivatedRouteSnapshot, state: RouterStateSnapshot) {
    let currentUser = new User(JSON.parse(localStorage.getItem('currentUser')));

    if (currentUser) {
      // logged in so return true
      debugger
      if (currentUser.isProfessor()) {
        this.router.navigate(['/my-students']);
      }
      else if (currentUser.isStudent()) {
        this.router.navigate(['/my-schedule']);
      }

      return true;
    }

    // not logged in so redirect to login page with the return url
    this.router.navigate(['/login'], { queryParams: { returnUrl: state.url }});
    return false;
  }
}
