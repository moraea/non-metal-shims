// credit EduCovas - implementation is required for fullscreen animation
// AppKit "screenshots" the window to animate smoothly, similar to light/dark transition

// TODO: working around a Renamer bug
// TODO: move to D2C?

#if MAJOR>=13

NSArray* SLSHWCaptureWindowLis$InRect(int edi_cid,int* rsi_list,int edx_count,unsigned int ecx_flags,CGRect stack);
NSArray* SLSHWCaptureWindowListInRect(int edi_cid,int* rsi_list,int edx_count,unsigned int ecx_flags,CGRect stack)
{
	// trace(@"SLSHWCaptureWindowListInRect flags %x",ecx_flags);
	
	// TODO: hack, not sure why new AppKit is messing up the flags
	// works, but we might sometimes want others...
	
	#define SHADOW 1
	#define JUST_WINDOW 8
	
	if(ecx_flags&SHADOW)
	{
		ecx_flags=SHADOW|JUST_WINDOW;
	}
	else
	{
		ecx_flags=0;
	}
	
	NSArray* result=SLSHWCaptureWindowLis$InRect(edi_cid,rsi_list,edx_count,ecx_flags,stack);
	uninvertScreenshots(result);
	return result;
}

#else

NSArray* SLSHWCaptureWindowListInRect(int edi_cid,int* rsi_list,int edx_count,unsigned int ecx_flags,CGRect stack);

#endif

NSArray* SLSHWCaptureWindowListInRectWithSeed(int edi_cid,int* rsi_list,int edx_count,unsigned int ecx_flags,int r8,CGRect stack)
{
	// i think *WithSeed is supposed to snapshot the window with the current in-progress transaction
	// but i have no idea how to do that, and this works
	// (otherwise the snapshot used for the animation looks a bit weird)
	
	CATransaction.commit;
	CATransaction.flush;
	
	return SLSHWCaptureWindowListInRect(edi_cid,rsi_list,edx_count,ecx_flags,stack);
}