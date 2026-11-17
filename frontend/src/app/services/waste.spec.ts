import { TestBed } from '@angular/core/testing';
import { provideHttpClient } from '@angular/common/http';
import { provideHttpClientTesting } from '@angular/common/http/testing';
import { WasteService } from './waste';

describe('WasteService', () => {
  let service: WasteService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [provideHttpClient(), provideHttpClientTesting()]
    });
    service = TestBed.inject(WasteService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});