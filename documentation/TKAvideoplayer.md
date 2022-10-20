![title](assets/TKAvideoplayer_titel_banner.png)
[![Generic badge](https://img.shields.io/badge/platform-android%20|%20ios%20-blue.svg)](https://git.informatik.hs-mannheim.de/a.babaoglu/CPD-Video-Player)

## Kontext und Idee

Im Rahmen des Wahlpflichtmoduls "Cross-Plattform Development mit Flutter" im Wintersemester 2021/2022 der Hochschule Mannheim wurden die Grundkonzepte an theoretischen und praktischen Beispielen über mehrere Vorlesungen hinweg vorgestellt. Neben der Vorlesung gehörte es zu diesem Modul dazu, eine App basierend auf der Technologie Flutter zu implementieren.  
Die mobile Anwendung, um die es in diesem Dokument handelt, wurde in Kooperation mit dem „Toni Kroos Academy“-Team entwickelt. Passend dazu wurden einige Wireframes und Anforderungen zur Verfügung gestellt, die als Grundlage genutzt werden konnten. Dementsprechend handelt es sich bei dieser Anwendung um eine Nachbildung der bestehenden Anwendung “Toni Kroos Academy“, bei der es an einigen nützlichen Funktionalitäten fehlte. Insbesondere wurde der Video Player im Hinblick auf Benutzerfreundlichkeit und Performance erheblich verbessert und um Funktionen erweitert, worum es in dieser Dokumentation hauptsächlich geht.

Dieses Dokument beschreibt hierzu grundlegende Funktionen dieser App, vor allem die des Video Players und stellt die Unterschiede zur bestehenden Toni Kroos Academy-App dar. Dabei wird an einigen Stellen auf technische Details eingegangen. Zudem werden einige Design-Entscheidungen aufgeführt, die für mögliche Leser bei ihrer Entwicklung sich als nützlich erweisen könnten.

## Video vom Durchlauf

[![Durchlauf Youtube Video](https://img.youtube.com/vi/5Vr_XHhF_-U/default.jpg)](https://www.youtube.com/watch?v=5Vr_XHhF_-U)

## Screens

**_Zum Vergrößern draufklicken_**

<table>
   <tr>
      <td>
         <img width="250px" src="assets/TKAvideoplayer_homescreen.png">
      </td>
      <td>
         <img width="250px" src="assets/TKAvideoplayer_homescreen_swipeup.png">
      </td>
      <td>
         <img width="250px" src="assets/TKAvideoplayer_academyview.png">
      </td>
   
   <td>
         <img width="250px" src="assets/TKAvideoplayer_academy_course.png">
      </td>
       <td>
         <img width="250px" src="assets/TKAvideoplayer_courselist_screen.png">
      </td>
      <td>
         <img width="250px" src="assets/TKAvideoplayer_portrait.png">
   </td>
      
   </tr>
 
   </table>
   <table>
   <tr>
      <td>
         <img width="250px" src="assets/TKAvideoplayer_landscape.png">
      </td>
       <td >
         <img width="250px" src="assets/TKAvideoplayer_subtitle.png">
      </td>
        <td >
         <img width="250px" src="assets/TKAvideoplayer_speed.png">
      </td>
      </tr>
     
   <tr>
     
   <td>
      <img width="250px" src="assets/TKAvideoplayer_settings.png">
   </td>
   <td>
      <img width="250px" src="assets/TKAvideoplayer_quality.png">
   </td>
   <td>
      <img width="250px" src="assets/TKAvideoplayer_language.png">
   </td>
   </tr>
   <tr>
      <td>
     <img width="250px" src="assets/TKAvideoplayer_recommandations.png">
      </td>
       <td >
       <img width="250px" src="assets/TKAvideoplayer_longpress.PNG">
      </td>
       <td >
        <img width="250px" src="assets/TKAvideoplayer_finish.png">
      </td>
      </tr>
        <tr>
        
   <td >
        <img  width="100px" src="assets/TKAvideoplayer_academy_category.png">
   </td>
   <td>
        <img height="100px" width="100px" src="assets/TKAvideoplayer_category_videos.png">
   </td>
</tr>
</table>

## Features

&nbsp;✔️ &nbsp;&nbsp;&nbsp;Start/Pause- Funktionalität<br>
&nbsp;✔️ &nbsp;&nbsp;&nbsp;Forward and Backward- Funktionalität<br>
&nbsp;✔️ &nbsp;&nbsp;&nbsp;Forward und Backward per Doppeltap möglich, wenn UI-Elemente ausgeblendet sind<br>
&nbsp;✔️ &nbsp;&nbsp;&nbsp;Untertitel einblenden ausblenden<br>
&nbsp;✔️ &nbsp;&nbsp;&nbsp; Sprachauswahl (Englisch, Deutsch)<br>
&nbsp;✔️ &nbsp;&nbsp;&nbsp; Videoqualität ändern<br>
&nbsp;✔️ &nbsp;&nbsp;&nbsp;Videogeschwindigkeit ändern über Slider (im Portrait über Menü wählbar, im Landscape direkt über Icon)<br>
&nbsp;✔️&nbsp;&nbsp;&nbsp; Ein-/Ausblenden von UI-Elementen<br>
&nbsp;✔️ &nbsp;&nbsp;&nbsp;Automatisches Ausblenden der UI-Elemente nach gewisser Zeit<br>
&nbsp;✔️ &nbsp;&nbsp;&nbsp;Progressbar zum Ändern der Position im Video<br>
&nbsp;✔️&nbsp;&nbsp;&nbsp; Videoposition per Longpress bestimmbar<br>
&nbsp;✔️&nbsp;&nbsp;&nbsp; Portrait und Landscape Modus (falls Rotation im System eingeschaltet)<br>
&nbsp;✔️&nbsp;&nbsp;&nbsp; Auswahl von weiteren Videos in Form einer Liste im Portrait-Modus<br>
&nbsp;✔️ &nbsp;&nbsp;&nbsp;Empfehlungen in Form von einem Bottom Sheet (nur im Landscape-Modus möglich)<br>
&nbsp;✔️&nbsp;&nbsp;&nbsp; Das Schließen des aktuell offenen Videos im Portrait-Modus, indem nach unten geswipt wird<br>
&nbsp;✔️ &nbsp;&nbsp;&nbsp;Das Video erneut anschauen, nachdem Video das Ende erreicht hat<br>
&nbsp;✔️ &nbsp;&nbsp;&nbsp;Auswahl anderer Videos , nachdem das Video das Ende erreicht hat (nur im Landscape-Modus)<br>
&nbsp;✔️&nbsp;&nbsp;&nbsp; Dark-Mode und Light-Mode wechseln<br>

#### Ausblick:

- Videos favorisieren
- Videos teilen über soziale Medien
- Chromcast auf verschiedenen Endgeräten
- Benutzerauthentifizierungsmechanismus
- Bewertungen von Videos
- Kommentar-Funktion

## Tech Stack

Frontend : **Flutter (Programmiersprache: Dart)**

Backend: **Node.js**

- Middleware-Schnittstelle: **Express.js**
- Ist ein **HTTP Live Streaming Server(HLS)**, der Antwort vor dem Senden komprimiert
- [**Mediastreamvalidator**](https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/StreamingMediaGuide/UsingHTTPLiveStreaming/UsingHTTPLiveStreaming.html#:~:text=Media%20Stream%20Validator) vom Apple für Performance-Bewertung unseres HLS- Servers
- Gehostet wird das Backend auf [**Heroku**](https://www.heroku.com/home)
- **HLS** Format für adaptive Bitrate-Streaming

## Übersicht Architektur

 <img src="assets/TKAvideoplayer_architecture.png">
 
### Anmerkung - Automatische Rotation Landscape/ Portrait Modus:
   Die Ausrichtungssperre muss auf dem Emulator/ Device deaktiviert werden, damit eine automatische Rotation erfolgen kann.

## Bugs in verwendeten Packages

#### Automatische Orientierung Landscape/ Portrait:

- Die Rotation von Portrait zu Landscape und umgekehrt funktioniert manchmal nicht ordnungsgemäß auf dem Emulator.<br>
  Jedoch treten die Probleme auf einem echten IOS/Android Device nicht auf.

#### Flutter Plugin video_player:

- Beim Flutter Plugin “video_player“ kommt es manchmal mit den darunterliegenden Videoplayern von IOS (AVPlayer) und Android (ExoPlayer) zu einer Race Condition.<br> Beim Auftreten des Bugs wird der Videoplayer nicht initialisiert und das Video startet nicht. Das Neustarten des Simulators behebt oftmals das Problem. Siehe Github Issue: https://github.com/flutter/flutter/issues/21483

![title](assets/TKAvideoplayer_endcard.png)
