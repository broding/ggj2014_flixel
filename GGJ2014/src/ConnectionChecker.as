package
{
    import flash.events.*;
    import flash.net.*;

    [Event(name="error", type="flash.events.Event")]
    [Event(name="success", type="flash.events.Event")]
    public class ConnectionChecker extends EventDispatcher
    {
        public static const EVENT_SUCCESS:String = "success";
        public static const EVENT_ERROR:String = "error";

        // Though google.com might be an idea, it is generally a better practice
        // to use a url with known content, such as http://foo.com/bar/mytext.txt
        // By doing so, known content can also be verified.

        // This would make the checking more reliable as the wireless hotspot sign-in
        // page would negatively intefere the result.
        private var _urlToCheck:String = "http://www.google.com";


        // empty string so it would always be postive
        private var _contentToCheck:String = "";    

        public function ConnectionChecker()
        {
            super();
        }

        public function check():void
        {
            var urlRequest:URLRequest = new URLRequest(_urlToCheck);
            var loader:URLLoader = new URLLoader();
            loader.dataFormat = URLLoaderDataFormat.TEXT;

            loader.addEventListener(Event.COMPLETE, loader_complete);
            loader.addEventListener(IOErrorEvent.IO_ERROR, loader_error);

            try
            {
                loader.load(urlRequest);
            }
            catch ( e:Error )
            {
                dispatchErrorEvent();
            }
        }

        private function loader_complete(event:Event):void
        {
            var loader:URLLoader = URLLoader( event.target );
            var textReceived:String = loader.data as String;

            if ( textReceived )
            {
                if ( textReceived.indexOf( _contentToCheck ) )
                {
                    dispatchSuccessEvent();
                }
                else
                {
                    dispatchErrorEvent();
                }
            }
            else
            {
                dispatchErrorEvent();
            }
        }

        private function loader_error(event:IOErrorEvent):void
        {
            dispatchErrorEvent();
        }


        private function dispatchSuccessEvent():void
        {
            dispatchEvent( new Event( EVENT_SUCCESS ) );
        }

        private function dispatchErrorEvent():void
        {
            dispatchEvent( new Event( EVENT_ERROR ) );
        }
    }
}