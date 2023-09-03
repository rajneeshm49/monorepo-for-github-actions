import { Component } from '@angular/core';
import { Injectable } from '@nestjs/common';
import { HttpClient } from '@angular/common/http';
import { Observable, tap } from 'rxjs';
import { environment } from '../environments/environment';

@Component({
  selector: 'monorepo-for-github-actions-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss'],
})
export class AppComponent {
  title = 'fe';

  constructor(private readonly http: HttpClient) {}

  onClick() {
    return this.http
      .get(`${environment.API_URL}/`)
      .pipe(
        tap((val: any) => {
          this.title = val['message'];
        })
      )
      .subscribe();
  }
}
