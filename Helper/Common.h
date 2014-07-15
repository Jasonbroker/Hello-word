/**
* customed logout
*/

#define KwordInSection 15

#ifdef DEBUG
#define Mylog(...)      NSlog(__VA_ARGS__)
#elif
#define Mylog(...)
#endif

/**
*   log function
*/

#define LogFunc         MyLog(@"%s", __func__);
#define LogObj(obj)         MyLog(@"%@", obj);
#define LogFrame(view)      MyLog(@"%@", NSStringFromCGRect(view.frame))
#define LogBounds(view)     MyLog(@"%@", NSStringFromCGRect(view.bounds))
