package  
{
	import flash.events.Event;
	import flash.geom.Point;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Nerdy Boyz
	 */
	public class Player extends FlxSprite
	{
		[Embed(source="../assets/eyeball player.png")] private var ImgPlayer:Class;
		
		private const _maxSpeed:int = 128;
		private const _tileSize:int = GameState.tileSize;
		private var _movementDirection:int = 0;// 0-idle 1-Left 2-Right 3-Up 4-Down
		private var _moving:Boolean = false;
		private var _moveingDelayPassed:Boolean = true;
		private var _lastIdlePosition:Point;
		private var _timeDelay:Number = 0.012;
		private var _timedelay:Number = 0;
		
		public function Player(X:int, Y:int):void 
		{
			super(X, Y);
			_lastIdlePosition = new Point(X, Y);
			this.loadGraphic(ImgPlayer, false, false, 64, 64);
		}
		
		override public function update():void
		{
			if (!_moving && _moveingDelayPassed)
			{
				if (FlxG.keys.LEFT)
				{
					_movementDirection = 1;
					_lastIdlePosition = new Point(this.x, this.y);
					_moving = true;
					_moveingDelayPassed = false;
				}else if (FlxG.keys.RIGHT)
				{
					_movementDirection = 2;
					_lastIdlePosition = new Point(this.x, this.y);
					_moving = true;
					_moveingDelayPassed = false;
				}else if (FlxG.keys.UP)
				{
					_movementDirection = 3;
					_lastIdlePosition = new Point(this.x, this.y);
					_moving = true;
					_moveingDelayPassed = false;
				}else if (FlxG.keys.DOWN)
				{
					_movementDirection = 4;
					_lastIdlePosition = new Point(this.x, this.y);
					_moving = true;
					_moveingDelayPassed = false;
				}
			}else
			{
				switch(_movementDirection)
				{
					case 0: //idle
						_moving = false;
						_timedelay += FlxG.elapsed;
						break;
					case 1: //left
						this.x -= this._maxSpeed * FlxG.elapsed;
						if (_lastIdlePosition.x - 64 >= this.x)
						{
							this.x = _lastIdlePosition.x - 64;
							_movementDirection = 0;
						}
						break;
					case 2: //right
						this.x += this._maxSpeed * FlxG.elapsed;
						if (_lastIdlePosition.x + 64 <= this.x)
						{
							this.x = _lastIdlePosition.x + 64;
							_movementDirection = 0;
						}
						break;
					case 3: //up
						this.y -= this._maxSpeed * FlxG.elapsed;
						if (_lastIdlePosition.y - 64 >= this.y)
						{
							this.y = _lastIdlePosition.y - 64;
							_movementDirection = 0;
						}
						break;
					case 4: //down
						this.y += this._maxSpeed * FlxG.elapsed;
						if (_lastIdlePosition.y + 64 <= this.y)
						{
							this.y = _lastIdlePosition.y + 64;
							_movementDirection = 0;
						}
						break;
				}
				if (_timedelay >= _timeDelay) _moveingDelayPassed = true;
			}
			
			super.update();
		}
		
	}

}