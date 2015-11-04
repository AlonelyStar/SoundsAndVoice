

#import "MJTypeEncoding.h"
#import "NSObject+MJCoding.h"
#import "NSObject+MJMember.h"
#import "NSObject+MJKeyValue.h"

#define MJLogAllIvrs \
- (NSString *)description \
{ \
    return [self keyValues].description; \
}
