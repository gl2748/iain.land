if ( ! Detector.webgl ) Detector.addGetWebGLMessage();

// Generic.
var container;
var canvas = document.getElementById( 'canvas' );
var camera, scene, renderer;
var mesh, mesh2, mesh3, dirLight, hemiLight, light;
var mouseX = 0, mouseY = 0,  mouseYThrottled = 0;
var windowHalfX = window.innerWidth / 2;
var windowHalfY = window.innerHeight / 2;

// Orbit control.
var controls;

// Shadows
var SHADOW_MAP_WIDTH = 2048, SHADOW_MAP_HEIGHT = 1024;
var HUD_MARGIN = 0.05;
var SCREEN_WIDTH = window.innerWidth;
var SCREEN_HEIGHT = window.innerHeight;
var FLOOR = - 250;
var camera, controls, scene, renderer;
var container, stats;
var NEAR = 10, FAR = 3000;
var mixer, morphs = [];
var light;
var lightShadowMapViewer;
var clock = new THREE.Clock();
var showHUD = false;

// Flies
var light1;
var clock = new THREE.Clock();
var osc = 2;

init();
animate();

function init() {

  scene = new THREE.Scene();

  // Add the renderer.
  renderer = new THREE.WebGLRenderer( { antialias: false } );
  renderer.setClearColor( 0xffffff );
  renderer.setPixelRatio( window.devicePixelRatio );

  // Set up the ShadowMap.
  renderer.shadowMap.enabled = true;
  renderer.shadowMap.type = THREE.PCFShadowMap;

  // Only take up half the vertical space.
  renderer.setSize( window.innerWidth, window.innerHeight/1.5 );

  // Attach the renderer as a domElement to the div with id #canvas.
  canvas.appendChild( renderer.domElement );

  // Camera.
  camera = new THREE.OrthographicCamera( window.innerWidth / - 2, window.innerWidth / 2, window.innerHeight / 3, window.innerHeight / - 3, - 500, 10000 );

  // Place camera on y axis
  camera.position.set(0,0,0);
  camera.position.z = 600;
  camera.position.y = 340;
  //camera.up = new THREE.Vector3(0,0,1);
  camera.lookAt(new THREE.Vector3(0,0,0));

  // Orbit control.
  //controls = new THREE.OrbitControls( camera, renderer.domElement );
  controls = new THREE.OrbitControls( camera, canvas  );
  //controls.addEventListener( 'change', render );
  //controls.addEventListener( 'change', render ); // add this only if there is no animation loop (requestAnimationFrame)
  controls.enableDamping = true;
  controls.dampingFactor = 0.9;
  controls.rotateSpeed = 0.5;
  controls.autoRotate = true;
  controls.autoRotateSpeed = 0.1;
  controls.enableZoom = false;
  controls.minPolarAngle = Math.PI/4; // radians

  //controls.maxPolarAngle = Math.PI; // radia
  controls.maxPolarAngle = Math.PI/2.2;

  // Lights.
  var ambient = new THREE.AmbientLight( 0x404040, 3.2 ); // soft white light
  scene.add( ambient );

  light = new THREE.SpotLight( 0xffffff, 0.18, 0, Math.PI / 2 );
  light.position.set( 700, 2000, 50 );
  light.target.position.set( 0, 0, 0 );
  light.castShadow = true;
  light.shadow = new THREE.LightShadow( new THREE.PerspectiveCamera( 50, 1, 1200, 2500 ) );
  light.shadow.bias = 0.0001;
  light.shadow.mapSize.width = SHADOW_MAP_WIDTH;
  light.shadow.mapSize.height = SHADOW_MAP_HEIGHT;
  scene.add( light );

  var loader = new THREE.JSONLoader();
  loader.load(
    // resource URL
    "../../3d/vrbaby3.json",
    // Function when resource is loaded
    createScene1
  );

  loader.load(
    // resource URL
    "../../3d/baby_bottle.json",
    // Function when resource is loaded
    createScene2
  );

   // Flies
  var sphere = new THREE.SphereGeometry( 2, 4, 4 );
  light1 = new THREE.PointLight( 0x222222, 2, 50 );
  light1.add( new THREE.Mesh( sphere, new THREE.MeshBasicMaterial( { color: 0x222222 } ) ) );
  scene.add( light1 );

  // Event Listeners.
  window.addEventListener( 'resize', onWindowResize, false );
}

function onWindowResize() {
  camera.aspect = window.innerWidth / window.innerHeight;
  camera.updateProjectionMatrix();
  renderer.setSize( window.innerWidth, window.innerHeight/1.5 );
}

// Add model as a child of the camera.
function createScene1( geometry, materials ) {
  // Ground.
  var myPlane = new THREE.PlaneBufferGeometry( 100, 100 );
  var planeMaterial = new THREE.MeshPhongMaterial( { color: 0xffffff } );
  var ground = new THREE.Mesh( myPlane, planeMaterial );
  ground.position.set( 0, -150, 0 );
  ground.rotation.x = - Math.PI / 2;
  ground.scale.x = 300;
  ground.scale.y = 300;
  ground.scale.z = 300;
  ground.castShadow = false;
  ground.receiveShadow = true;
  scene.add( ground );

  materials[ 0 ].shading = THREE.SmoothShading;
  mesh = new THREE.Mesh( geometry, new THREE.MultiMaterial( materials ));
  mesh.position.set( 0, -150, 0 );
  mesh.scale.x = mesh.scale.y = mesh.scale.z = 16;
  mesh.castShadow = true;
  mesh.receiveShadow = true;

  scene.add( mesh );
}

// Add model of baby bottle.
function createScene2( geometry, materials ) {
  mesh = new THREE.Mesh( geometry, new THREE.MultiMaterial( materials ));
  mesh.position.set( 200, -150, 10 );
  mesh.scale.x = mesh.scale.y = mesh.scale.z = 20;
  mesh.castShadow = true;
  mesh.receiveShadow = true;

  scene.add( mesh );
}

function animate() {

  var time = Date.now() * 0.003;

  light1.position.x = 200 + Math.sin( time * 0.7 ) * 30 + osc*Math.random();
  light1.position.y = Math.cos( time * 0.5 ) * 40 + osc*Math.random();
  light1.position.z = Math.cos( time * 0.3 ) * 30;

  osc = osc * -1;

  requestAnimationFrame( animate );
  controls.update(); // required if controls.enableDamping = true, or if controls.autoRotate = true
  render();
}

function render() {
  // Render the scene.
  renderer.render( scene, camera );
}
