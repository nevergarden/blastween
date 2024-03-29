package;

import blastween.Easing;
import tink.testrunner.Assertion;
import tink.testrunner.Assertions;
import tink.core.Error;
import haxe.Exception;
import tink.unit.Assert;
import blastween.UpdateManager;
import blastween.Blastween;
import tink.CoreApi.Noise;
import blastween.TweenObject;
import tink.testrunner.Batch;
import tink.testrunner.Runner;
import tink.unit.TestBatch;

typedef TweenTestType = {
	var integer:Int;
	var float:Float;
	var ?typein:TweenTestType;
}

class TweenTestClass {
	public var integer:Int;
	public var float:Float;

	public function new(integer:Int, float:Float) {
		this.integer = integer;
		this.float = float;
	}
}

@:await
class TestLinear {
	private var typeTweenData:TweenTestType;
	private var classTweenData:TweenTestClass;
	private var typeTweenObject:TweenObject;

	public function new() {}

	@:setup
	public function setup():Noise {
		this.typeTweenData = {
			integer: 0,
			float: 0,
		};
		this.classTweenData = new TweenTestClass(0, 0);
		return Noise;
	}

	@:describe("Test type data change.")
	public function testTypeUpdate():Assertions {
		this.typeTweenObject = Blastween.tween(typeTweenData, {integer: 0, float: 0.0}, {integer: 1, float: 1.0}, 2.0).start();
		var assertions:Array<Assertion> = [];
		try {
			this.typeTweenObject.update(0.4);
			assertions.push(Assert.assert(typeTweenData.integer == 0));
			assertions.push(Assert.assert(typeTweenData.float == 0.2));

			this.typeTweenObject.update(0.6);
			assertions.push(Assert.assert(typeTweenData.integer == 0));
			assertions.push(Assert.assert(typeTweenData.float == 0.5));

			this.typeTweenObject.update(1.0);
			assertions.push(Assert.assert(typeTweenData.integer == 1));
			assertions.push(Assert.assert(typeTweenData.float == 1.0));

			this.typeTweenObject.update(1.0);
			assertions.push(Assert.assert(typeTweenData.integer == 1));
			assertions.push(Assert.assert(typeTweenData.float == 1.0));
		} catch (e:Exception) {
			return Assert.fail(new Error(InternalError, e.message));
		}
		return assertions;
	}

	@:describe("Test class data change.")
	public function testClassUpdate():Assertions {
		this.typeTweenObject = Blastween.tween(classTweenData, {integer: 0, float: 0.0}, {integer: 1, float: 1.0}, 2.0).start();
		var assertions:Array<Assertion> = [];
		try {
			this.typeTweenObject.update(0.4);
			assertions.push(Assert.assert(classTweenData.integer == 0));
			assertions.push(Assert.assert(classTweenData.float == 0.2));

			this.typeTweenObject.update(0.6);
			assertions.push(Assert.assert(classTweenData.integer == 0));
			assertions.push(Assert.assert(classTweenData.float == 0.5));

			this.typeTweenObject.update(1.0);
			assertions.push(Assert.assert(classTweenData.integer == 1));
			assertions.push(Assert.assert(classTweenData.float == 1.0));

			this.typeTweenObject.update(1.0);
			assertions.push(Assert.assert(classTweenData.integer == 1));
			assertions.push(Assert.assert(classTweenData.float == 1.0));
		} catch (e:Exception) {
			return Assert.fail(new Error(InternalError, e.message));
		}
		return assertions;
	}
}

@:await
class TestEasing {
	private var typeTweenData:TweenTestType;
	private var classTweenData:TweenTestClass;
	private var typeTweenObject:TweenObject;

	public function new() {}

	@:setup
	public function setup():Noise {
		this.typeTweenData = {
			integer: 0,
			float: 0,
		};
		this.classTweenData = new TweenTestClass(0, 0);
		return Noise;
	}

	@:describe("Tween with quad easing.")
	public function quadTween():Assertions {
		this.typeTweenObject = Blastween.tween(classTweenData, {integer: 0, float: 0.0}, {integer: 10, float: 10.0}, 5.0).setEase(Easing.QUAD_IN).start();
		var assertions:Array<Assertion> = [];
		try {
			this.typeTweenObject.update(0.4);
			assertions.push(Assert.assert(classTweenData.integer == 0));
			assertions.push(Assert.assert(classTweenData.float == 0.064));

			this.typeTweenObject.update(0.6);
			assertions.push(Assert.assert(classTweenData.integer == 0));
			assertions.push(Assert.assert(Std.int(classTweenData.float * 10) == 4));

			this.typeTweenObject.update(2.0);
			assertions.push(Assert.assert(classTweenData.integer == 3));
			assertions.push(Assert.assert(Std.int(classTweenData.float * 10) == 36));

			this.typeTweenObject.update(2.0);
			assertions.push(Assert.assert(classTweenData.integer == 10));
			assertions.push(Assert.assert(classTweenData.float == 10.0));

			this.typeTweenObject.update(1.0);
			assertions.push(Assert.assert(classTweenData.integer == 10));
			assertions.push(Assert.assert(classTweenData.float == 10.0));
		} catch (e:Exception) {
			return Assert.fail(new Error(InternalError, e.message));
		}
		return assertions;
	}
}

class RunTests {
	public static function main() {
		var testBatch:tink.testrunner.Batch = TestBatch.make([new TestLinear(), new TestEasing()]);

		Runner.run(testBatch).handle(tink.testrunner.Runner.exit);
	}
}
