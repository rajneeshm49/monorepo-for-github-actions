import { Component } from '@angular/core';
import { Injectable } from '@nestjs/common';
import { HttpClient } from '@angular/common/http';
import { Observable, tap } from 'rxjs';
import { environment } from '../environments/environment';
import { AppService } from './appconfig.service';

@Component({
  selector: 'monorepo-for-github-actions-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss'],
})
export class AppComponent {
  title = 'fe';
  appData: any;

  constructor(
    private readonly http: HttpClient,
    private appService: AppService
  ) {
    this.appData = this.appService.settings;
    console.log('hola', this.appData);
  }

  onClick() {
    return this.http
      .get(`${this.appData.API_URL}/`)
      .pipe(
        tap((val: any) => {
          this.title = val['message'];
        })
      )
      .subscribe();
  }
}
