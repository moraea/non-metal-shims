// work around lifecycle issues (can't quit, 1200 second crash)

BOOL (*real_addCommitHandler)(CATransaction*,SEL,void*,int);
BOOL fake_addCommitHandler(CATransaction* self,SEL sel,void* rdx_block,int ecx_phase)
{
	if(ecx_phase==5)
	{
		ecx_phase=4;
	}
	
	real_addCommitHandler(self,sel,rdx_block,ecx_phase);
	
	return true;
}

// TODO: upside-down

// fix crashes due to CALayer.delegate being released prematurely
// TODO: confirm there is no memory leak

#ifndef CAT

@interface CALayer(Shim)
@end

static char KEY_RETAINED_DELEGATE;
BOOL delegateWasRetained(NSObject* delegate)
{
	if(!delegate)
	{
		return false;
	}
	
	NSNumber* value=objc_getAssociatedObject(delegate,&KEY_RETAINED_DELEGATE);
	
	// trace(@"CALayer delegateWasRetained %@",value);
	
	return value.boolValue;
}
void setDelegateWasRetained(NSObject* delegate,BOOL flag)
{
	// trace(@"CALayer setDelegateWasRetained %d",flag);
	
	objc_setAssociatedObject(delegate,&KEY_RETAINED_DELEGATE,[NSNumber numberWithBool:flag],OBJC_ASSOCIATION_RETAIN);
}
void releaseLayerDelegateIfNecessary(CALayer* layer)
{
	NSObject* delegate=[layer delegate];
	if(delegateWasRetained(delegate))
	{
		setDelegateWasRetained(delegate,false);
		delegate.release;
	}
}

@implementation CALayer(Shim)

-(void)setUnsafeUnretainedDelegate:(NSObject*)rdx
{
	[self setDelegate:rdx];
	
	rdx.retain;
	setDelegateWasRetained(rdx,true);
}

-(NSObject*)unsafeUnretainedDelegate
{
	return [self delegate];
}

@end

void (*real_setDelegate)(NSObject*,SEL,NSObject*);
void fake_setDelegate(NSObject* self,SEL sel,NSObject* delegate)
{
	releaseLayerDelegateIfNecessary(self);
	
	real_setDelegate(self,sel,delegate);
}

void (*real_dealloc)(NSObject*,SEL);
void fake_dealloc(NSObject* self,SEL sel)
{
	releaseLayerDelegateIfNecessary(self);
	
	real_dealloc(self,sel);
}

#endif

void catalystSetup()
{
	swizzleImp(@"CATransaction",@"addCommitHandler:forPhase:",false,(IMP)fake_addCommitHandler,(IMP*)&real_addCommitHandler);
	
#ifndef CAT
	swizzleImp(@"CALayer",@"setDelegate:",true,(IMP)fake_setDelegate,(IMP*)&real_setDelegate);
	swizzleImp(@"CALayer",@"dealloc",true,(IMP)fake_dealloc,(IMP*)&real_dealloc);
#endif
}