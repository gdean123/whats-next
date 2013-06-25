#ifndef Constants_h
#define Constants_h

#ifdef DEVELOPMENT
#define ROOT_URL @"http://localhost:3000"
#endif

#ifdef STAGING
#define ROOT_URL @"http://engage-me-api.herokuapp.com/"
#endif

#ifdef PRODUCTION
#define ROOT_URL @"http://production.example.com"
#endif

#endif