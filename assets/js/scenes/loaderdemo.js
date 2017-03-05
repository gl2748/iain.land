var container

var camera, scene, renderer;

var geometry, root, root2, objectToggleAddRemove;

//Origin is (0,0)
//Radius of our  circle is 1000
var originX = 0;
var originY = 0;
var originZ = 0;
var offsetY = - 0.1;
var radius = 2;
var count = 0;
var colorCount = 0;
var length = 400;

var trails = [];
var trails2 = [];
var trail, trail2;

var colors = [ 0x289FC7, 0x51DB56, 0xE647A9];
var trailColor1 = 0xff0040;
var trailColor2 = 0x355FDE;
var clickCounter = 0;
var clickColor = 0xEBA35B;

var mouseX = 0, mouseY = 0;
var windowHalfX = window.innerWidth / 2;
var windowHalfY = window.innerHeight / 2;

document.addEventListener( 'mousemove', onDocumentMouseMove, false );
document.addEventListener( 'mousedown', onDocumentMouseDown, false );
document.addEventListener( 'touchstart', onDocumentTouchStart, false );

init();
animate();

function init() {

  container = document.createElement( 'div' );
  document.body.appendChild( container );

  camera = new THREE.PerspectiveCamera( 60, window.innerWidth / window.innerHeight, 1, 15000 );
  camera.position.z = 50;
  camera.position.y = -17;

  scene = new THREE.Scene();

  var geometry = new THREE.SphereGeometry( 2, 16, 16 );
  var material = new THREE.MeshBasicMaterial( { color: 0xff0040 } )

  for ( var i = 0; i < length; i ++ ) {
    trail = new THREE.Mesh( geometry, new THREE.MeshBasicMaterial( { color: trailColor1 } ) );
    trail.position.y = i * offsetY;
    trails[i] = trail;
  };

  for ( var i = 0; i < length; i ++ ) {
    trail2 = new THREE.Mesh( geometry, new THREE.MeshBasicMaterial( { color: trailColor2 } ) );
    trail2.position.y = i * offsetY;
    trails2[i] = trail2;
  };

  trails.forEach(function(trail){
    scene.add( trail );
  });

  trails2.forEach(function(trail){
    scene.add( trail );
  });

  renderer = new THREE.WebGLRenderer({});
  renderer.setClearColor( 0x000000 );
  renderer.setPixelRatio( window.devicePixelRatio );
  renderer.setSize( window.innerWidth, window.innerHeight );
  renderer.sortObjects = false;
  container.appendChild( renderer.domElement );

  window.addEventListener( 'resize', onWindowResize, false );
}

function onWindowResize() {
  windowHalfX = window.innerWidth / 2;
  windowHalfY = window.innerHeight / 2;
  camera.aspect = window.innerWidth / window.innerHeight;
  camera.updateProjectionMatrix();
  renderer.setSize( window.innerWidth, window.innerHeight );
}

function onDocumentMouseMove(event) {
  mouseX = ( event.clientX - windowHalfX ) * 10;
  mouseY = ( event.clientY - windowHalfY ) * 10;
}

function onDocumentMouseDown(event) {
  colorCount = 0;
  clickColor = colors[clickCounter];
  clickColor2 = colors[clickCounter - 1];
  clickCounter += 1;
  if (clickCounter > 2) {
    clickCounter = 0;
  }
}

function onDocumentTouchStart( event ) {
  colorCount = 0;
  clickColor = colors[clickCounter];
  clickColor2 = colors[clickCounter - 1];
  clickCounter += 1;
  if (clickCounter > 2) {
    clickCounter = 0;
  }
}

function animate() {
  requestAnimationFrame( animate );
  render();
}

function render() {

  for ( var i = 0; i < trails.length; i ++ ) {
    var nudge = i * 0.03;
    trails[ i ].position.x = originX + radius * Math.cos(nudge + count*0.03);
    trails[ i ].position.z = originZ + radius * Math.sin(nudge + count*0.03);
  }

  trails[ colorCount ].material.color.setHex(clickColor);

  for ( var i = 0; i < trails2.length; i ++ ) {
    var nudge = i * 0.03;
    trails2[ i ].position.x = originX + radius * Math.cos(Math.PI + nudge + count*0.03);
    trails2[ i ].position.z = originZ + radius * Math.sin(Math.PI + nudge + count*0.03);
  }

  count += 1;
  colorCount += 1;

  if (colorCount > length -1 ) {
    colorCount = 0;
  }
  renderer.render( scene, camera );
}
