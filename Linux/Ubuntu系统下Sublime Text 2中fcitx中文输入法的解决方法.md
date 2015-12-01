### 保存一下代码，文件名　sublime-imfix.c



```java

/*
sublime-imfix.c
Use LD_PRELOAD to interpose some function to fix sublime input method support for linux.
By Cjacker Huang &lt;jianzhong.huang at i-soft.com.cn&gt;

gcc -shared -o libsublime-imfix.so sublime_imfix.c  `pkg-config --libs --cflags gtk+-2.0` -fPIC
LD_PRELOAD=./libsublime-imfix.so sublime_text
*/
#include &lt;gtk/gtk.h&gt;
#include &lt;gdk/gdkx.h&gt;
typedef GdkSegment GdkRegionBox;

struct _GdkRegion
{
  long size;
  long numRects;
  GdkRegionBox *rects;
  GdkRegionBox extents;
};

GtkIMContext *local_context;

void
gdk_region_get_clipbox (const GdkRegion *region,
            GdkRectangle    *rectangle)
{
  g_return_if_fail (region != NULL);
  g_return_if_fail (rectangle != NULL);

  rectangle-&gt;x = region-&gt;extents.x1;
  rectangle-&gt;y = region-&gt;extents.y1;
  rectangle-&gt;width = region-&gt;extents.x2 - region-&gt;extents.x1;
  rectangle-&gt;height = region-&gt;extents.y2 - region-&gt;extents.y1;
  GdkRectangle rect;
  rect.x = rectangle-&gt;x;
  rect.y = rectangle-&gt;y;
  rect.width = 0;
  rect.height = rectangle-&gt;height; 
  //The caret width is 2; 
  //Maybe sometimes we will make a mistake, but for most of the time, it should be the caret.
  if(rectangle-&gt;width == 2 &amp;&amp; GTK_IS_IM_CONTEXT(local_context)) {
        gtk_im_context_set_cursor_location(local_context, rectangle);
  }
}

//this is needed, for example, if you input something in file dialog and return back the edit area
//context will lost, so here we set it again.

static GdkFilterReturn event_filter (GdkXEvent *xevent, GdkEvent *event, gpointer im_context)
{
    XEvent *xev = (XEvent *)xevent;
    if(xev-&gt;type == KeyRelease &amp;&amp; GTK_IS_IM_CONTEXT(im_context)) {
       GdkWindow * win = g_object_get_data(G_OBJECT(im_context),"window");
       if(GDK_IS_WINDOW(win))
         gtk_im_context_set_client_window(im_context, win);
    }
    return GDK_FILTER_CONTINUE;
}

void gtk_im_context_set_client_window (GtkIMContext *context,
          GdkWindow    *window)
{
  GtkIMContextClass *klass;
  g_return_if_fail (GTK_IS_IM_CONTEXT (context));
  klass = GTK_IM_CONTEXT_GET_CLASS (context);
  if (klass-&gt;set_client_window)
    klass-&gt;set_client_window (context, window);

  if(!GDK_IS_WINDOW (window))
    return;
  g_object_set_data(G_OBJECT(context),"window",window);
  int width = gdk_window_get_width(window);
  int height = gdk_window_get_height(window);
  if(width != 0 &amp;&amp; height !=0) {
    gtk_im_context_focus_in(context);
    local_context = context;
  }
  gdk_window_add_filter (window, event_filter, context); 
}

```



### 安装C/C++的编译环境和gtk libgtk2.0-dev

    sudo apt-get install build-essential
    sudo apt-get install libgtk2.0-dev



### 编译共享内库

gcc -shared -o libsublime-imfix.so sublime_imfix.c  \`pkg-config --libs --cflags gtk+-2.0\` -fPIC



### 打开终端进入applications修改sublime-text-2.desktop



    cd /usr/share/applications
    sudo vim sublime-text-2.desktop



打开sublime-text-2.desktop后，将

                 

　　　　Exec=/usr/bin/sublime-text-2 %F　修改为

　　　　Exec=bash -c 'LD_PRELOAD=/usr/lib/libsublime-imfix.so /usr/bin/sublime-text-2' %F

　　　　Exec=/usr/bin/sublime-text-2 --new-window　修改为

　　　　Exec=bash -c 'LD_PRELOAD=/usr/lib/libsublime-imfix.so /usr/bin/sublime-text-2' --new-window