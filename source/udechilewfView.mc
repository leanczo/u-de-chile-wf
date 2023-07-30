import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
using Toybox.ActivityMonitor as Act;
using Toybox.Activity as Acty;


class udechilewfView extends WatchUi.WatchFace {
	var logo;
    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
        logo = WatchUi.loadResource(Rez.Drawables.Logo);
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Get the current time and format it correctly
        var timeFormat = "$1$:$2$";
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;
        if (!System.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        } else {
            if (getApp().getProperty("UseMilitaryFormat")) {
                timeFormat = "$1$$2$";
                hours = hours.format("%02d");
            }
        }
        var timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        
        var widthScreen = dc.getWidth();
		var heightScreen = dc.getHeight();
  		var widthCenter = widthScreen / 2;
  		var heightCenter = heightScreen / 2;
  		
  		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(widthCenter , heightCenter , 150);
		
		dc.setColor(Graphics.COLOR_DK_BLUE, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(widthCenter , heightCenter , widthCenter - 10);
        
        // lines
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle(0,heightCenter, widthScreen , 5);
		
		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle(0,heightCenter + 10, widthScreen , 5);
		
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle(0,heightCenter - 10, widthScreen , 5);
		
        // Logo
        var positionLogoX = (widthScreen / 2) - 42;
        var positionLogoY = (heightScreen / 2) - 70;
        dc.drawBitmap(positionLogoX, positionLogoY, logo);
        
        // Time
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(widthCenter, (heightScreen / 8) * 6, Graphics.FONT_LARGE, timeString, Graphics.TEXT_JUSTIFY_CENTER);
        
    	// Steps
    	if(getApp().getProperty("ShowSteps"))
    	{
	    	var positionXFootstepsText = widthScreen / 2;
	        var positionYFootstepsText = heightScreen / 8;
	        var steps = ActivityMonitor.getInfo().steps.toString();
	        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
			dc.drawText(positionXFootstepsText, positionYFootstepsText, Graphics.FONT_SYSTEM_XTINY, steps + " Steps", Graphics.TEXT_JUSTIFY_CENTER);
    	}
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
