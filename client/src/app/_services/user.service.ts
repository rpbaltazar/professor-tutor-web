import { Injectable } from '@angular/core';
import { Http, Headers, Response, RequestOptionsArgs } from '@angular/http';
import { Observable } from 'rxjs/Observable';
import { User } from '../_models/index';
import 'rxjs/add/operator/map'

@Injectable()
export class UserService {
  constructor(private http: Http) { }

  getStudents(professor: User): Promise<Array<User>> {
    return new Promise( (resolve, reject) => {
      let mobileApi = 'https://professor-tutor.herokuapp.com/';

      let headers = new Headers();
      headers.append('Authorization', `Token ${professor.apiKey}`);
      let opts:RequestOptionsArgs = { headers: headers };

      this.http.get(`${mobileApi}v1/users`, opts)
        .subscribe(
          data => {
            let students: Array<User> = []
            let studentsData = data.json()
            students = studentsData.map((student) => {
              return new User(student);
            })

            resolve(students);
          },
          error => {
            reject(error);
        });
    });
  }

  login(email: string, password: string) {
    let mobileApi = 'https://professor-tutor.herokuapp.com/';

    return this.http.post(`${mobileApi}users/sign_in`, { email: email, password: password })
      .map((response: Response) => {
        // login successful if there's a jwt token in the response
        let user = response.json();
        if (user && user.api_key) {
          // store user details and jwt token in local storage to keep user logged in between page refreshes
          localStorage.setItem('currentUser', JSON.stringify(user));
        }
      });
  }

  logout() {
    // remove user from local storage to log user out
    localStorage.removeItem('currentUser');
  }
}
