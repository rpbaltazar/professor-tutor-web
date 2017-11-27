import * as moment from 'moment';
import * as momenttz from "moment-timezone"
import * as _ from 'lodash';

// import { Env } from '../config/env';

export class StudyHour {
  id: number;
  user_id: number;
  startTime: any;
  endTime: any;
  startedAt: any;
  completedAt: any;
  description: string;

  public static fromJSON(json): StudyHour {
    let timezone = "SGT" //Env.getEnvValue("TIMEZONE")
    let studyHour: StudyHour = new StudyHour()
    studyHour.id = Number(json["id"]);
    studyHour.user_id = Number(json["user_id"]);
    studyHour.startTime = momenttz(json["start_time"]).tz(timezone)
    studyHour.endTime = momenttz(json["end_time"]).tz(timezone);
    studyHour.startedAt = json["started_at"];
    studyHour.completedAt = json["completed_at"];
    studyHour.description = json["description"];
    return studyHour;
  }

  isStarted(): boolean {
    return !_.isEmpty(this.startedAt);
  }

  isComplete(): boolean {
    return !_.isEmpty(this.completedAt);
  }

  durationInMinutes(): number {
    return this.endTime.diff(this.startTime, 'minutes')
  }

  formattedDateTimeInfo(): string {
    return `${this.formattedStartTime()} to ${this.formattedEndTime()}`
  }

  formattedStartTime(): string {
    return this.startTime.format();//Env.getEnvValue("DATETIME_FORMAT"));
  }

  formattedEndTime(): string {
    return this.endTime.format();//Env.getEnvValue("DATETIME_FORMAT"))
  }
}
