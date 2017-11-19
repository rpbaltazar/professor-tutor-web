import { Component } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { AuthenticationService } from './_services/index';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'Professor Tutor';

  constructor(
    private router: Router,
    private authenticationService: AuthenticationService) { }

  logout() {
    this.authenticationService.logout();
    this.router.navigate(['/']);
  }

  public isHidden() {
    let list = ["/login", "/register"],
        fullRoute = this.router.url

    let route = fullRoute.split('?')[0];

    return (list.indexOf(route) > -1);
  }
}
