
const CACHE='pfg-fragrance-v1-7';
const APP_SHELL=[
  './',
  './index.html',
  './manifest.webmanifest',
  './content_anchor_manifest_v1.json',
  './assets/current-proof-v2.pdf',
  './assets/4711.png',
  './assets/4711-corrected.png',
  './assets/marlborough.png',
  './assets/green-water.jpeg',
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
