
const CACHE='pfg-final-v2';
const APP_SHELL=[
  './',
  './index.html',
  './manifest.webmanifest',
  './assets/4711.png',
  './assets/CITRUS_AURANTIUM.jpg',
  './assets/GARAGE.jpg',
  './assets/GREEN_WATER.jpeg',
  './assets/MARLBOROUGH.png',
  './assets/OBJECTS_OF_SMELL.jpg',
  './assets/PETRICHOR.jpg',
  './assets/Personal_Field_Guide_No01_Canvas_Cover_Concept.png',
  './assets/RESIN_SPICE_TOBACCO_LEATHER.png',
  './assets/RIVER_STONE.jpg',
  './icons/icon-192.svg',
  './icons/icon-512.svg'
];

self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE).then(cache =>
      Promise.allSettled(APP_SHELL.map(url => cache.add(url)))
    )
  );
  self.skipWaiting();
});

self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys().then(keys =>
      Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k)))
    )
  );
  self.clients.claim();
});

self.addEventListener('fetch', event => {
  const req=event.request;
  const url=new URL(req.url);
  if (req.method !== 'GET') return;
  if (url.origin !== self.location.origin) return;
  event.respondWith(
    caches.match(req).then(cached => {
      const network=fetch(req).then(resp => {
        if (resp && resp.ok) {
          const copy=resp.clone();
          caches.open(CACHE).then(cache => cache.put(req, copy));
        }
        return resp;
      }).catch(() => cached);
      return cached || network;
    })
  );
});
