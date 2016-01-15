# YNModalView

The purpose of this project/library is to build an extensible, modally-presented view that can be shown and dismissed easily. It will first be used in Yonder's BoomView (where it will contain a switch, a text field, and a table view), but it should practically be able to display all manner of content. 

Architecturally, the library will know how to present a view inside of another view (about which it should know not much), with some default settings for showing a title and content view (though perhaps I'll bake in some niceties for Yonder's main use-cases here, such as a table view and a switch). Those default settings should be overrideable via delegate callbacks. 

Open questions: 
* How will the presenting view be modified? Ideally it will be dimmed, or have a froste-glass effect - will YNModalView know anything about that? 
* How will it animate in? Can that animation be customized (via a YNModalViewDelegate)? 

## Mockup:

![alt tag](https://raw.githubusercontent.com/worthbak/YNModalView/master/boomview_search.png)