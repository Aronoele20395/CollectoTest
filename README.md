Durante lo svolgimento dell'esercizio mi sono permessa di effettuare alcune modifiche rispetto all'interfaccia che mi è stata fornita; prima tra tutte, l'inserimento di un set di frecce di navigazione per facilitare lo scroll orizzontale dei vari gruppi di prodotti per la versione desktop.

Volendo inoltre proporre una versione funzionante di caricamento paginato degli elementi, ho deciso di implementare un'ulteriore riga di prodotti che contenesse tutti gli ementi presi da tutte le categorie (decisione, questa, vincolata dal fatto che le API esposte restituivano solamente un set limitato di risultati, non permettendo cosi un caricamento paginato degli elementi).

Sempre citando la struttura limitata delle API esposte, mi sento di dire di non esser riuscita a proporre una versione efficiente (ma comunque corretta) del fetch paginato dei prodotti; questo è dovuto al fatto che il set di filtri atteso dalla chiamata conteneva al suo interno la sola proprietà denominata "limit" ma non "offset", utile all'implementazione.

Ultimo appunto va alla ricerca che presenta un errore in fase di reset del parametro; per motivi di tempistiche, infatti, non ho avuto la possibilità di sanare un bug legato alla cancellazione, carattere per carattere, del parametro inserito all'interno della barra di ricerca.
Seguendo infatti questo flusso, l'applicazione presenta un messaggio di errore se, durante la cancellazione, i caratteri rimanenti del parametro di ricerca matchano con una delle righe di prodotti che era statsa in precedenza nascosta dall'applicazione della ricerca.
