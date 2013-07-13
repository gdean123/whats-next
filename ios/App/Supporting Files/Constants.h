#ifndef Constants_h
#define Constants_h

#ifdef DEVELOPMENT
#define ROOT_URL @"http://localhost:3000"
#endif

#ifdef TEST
#define ROOT_URL @"http://localhost:3001"
#endif

#ifdef STAGING
#define ROOT_URL @"http://engage-me-api-staging.herokuapp.com"
#endif

#ifdef PRODUCTION
#define ROOT_URL @"http://engage-me-api.herokuapp.com"
#endif

#endif