Readme for the OASIS PDF plug-in
Original creation: KJE 30 Jan 2019
Last update: KJE 27 Sep 2020
--------------------------------------------------------------------

This plug-in runs on DITA-0T 3.5.3 and uses Antenna House Formatter
for official TC PDFs. (You can use FOP for unofficial PDFs.) 
It requires a system with the Liberation Sans font installed.

It defines three transformations:

 * oasis-pdf-committeeNote    (OASIS committee note)
 * oasis-pdf-specification    (OASIS specification)
 * oasis-pdf-generic          (Generic PDF, body uses spec styles)
 
 The template directory contains starter files for new
 specifications and committee notes.
 
 The spec and committee note transformations rely on certain keys
 and outputclass values.
 
 Outputclass values:
 
 * outputclass="notices" must be set on the root of the notices topic.
   If this is not present, the topic will not be rendered.
 * outputclass="RFC-2119" must be set on <term> elements that contain
   RFC-2119 terms. (Spec only)
 * outputclass="documentStage" must be set on the <booktitlealt> element
   that contains the document stage.
 * outputclass="stageDate" must be set on the <booktitlealt> element
   that contains the publication date.
   
 Key values:
 
 * The "stage-date" key is used by the footers in the spec and committee note
   styles.
   
 I *strongly* suggest that DITA TC specs and committee notes use the same key 
 names for cover page information. Here is an example:
 
  <booktitle>
    <mainbooktitle>Lightweight DITA Version 1.0</mainbooktitle>
    <booktitlealt outputclass="documentStage">
      <keyword keyref="stage"/>
    </booktitlealt>
    <booktitlealt outputclass="stageDate">
      <keyword keyref="stage-date"/>
    </booktitlealt>
 </booktitle>
