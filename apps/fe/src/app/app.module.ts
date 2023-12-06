import { APP_INITIALIZER, NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { AppComponent } from './app.component';
import { NxWelcomeComponent } from './nx-welcome.component';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { AppService } from './appconfig.service';

export function init_app(appService: AppService) {
  return () => appService.load();
}
@NgModule({
  declarations: [AppComponent, NxWelcomeComponent],
  imports: [BrowserModule, HttpClientModule],
  providers: [
    {
      provide: APP_INITIALIZER,
      useFactory: init_app,
      deps: [AppService],
      multi: true,
    },
  ],
  bootstrap: [AppComponent],
})
export class AppModule {}
