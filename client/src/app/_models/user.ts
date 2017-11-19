export class User {
  id: number;
  email: string;
  password: string;
  firstName: string;
  lastName: string;
  userType: string;

  constructor(userJSON:any) {
    this.id = userJSON.id;
    this.firstName = userJSON.first_name;
    this.lastName = userJSON.last_name;
    this.email = userJSON.email;
    this.userType = userJSON.user_type;
  }

  public isProfessor(): boolean {
    return this.userType == "Professor";
  }

  public isStudent(): boolean {
    return this.userType == "Student";
  }
}
