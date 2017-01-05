<div>
<h1>README</h1>

<div>
<h2><a id="readme-general">OASIS Open Repository: dita-stylesheets</a></h2>

<p>This GitHub public repository ( <b><a href="https://github.com/oasis-open/dita-stylesheets">https://github.com/oasis-open/dita-stylesheets</a></b> ) was created at the request of the <a href="https://www.oasis-open.org/committees/dita/">OASIS Darwin Information Typing Architecture (DITA) TC</a> as an <a href="https://www.oasis-open.org/resources/open-repositories/">OASIS Open Repository</a> to support development of open source resources related to Technical Committee work.</p>

<p>While this Open Repository remains associated with the sponsor TC, its development priorities, leadership, intellectual property terms, participation rules, and other matters of governance are <a href="https://github.com/oasis-open/dita-stylesheets/blob/master/CONTRIBUTING.md#governance-distinct-from-oasis-tc-process">separate and distinct</a> from the OASIS TC Process and related policies.</p>

<p>All contributions made to this Open Repository are subject to open source license terms expressed in the <a href="https://www.oasis-open.org/sites/www.oasis-open.org/files/Apache-LICENSE-2.0.txt">Apache License v 2.0</a>.  That license was selected as the declared <a href="https://www.oasis-open.org/resources/open-repositories/licenses">"Applicable License"</a> when the Open Repository was created.</p>

<p>As documented in <a href="https://github.com/oasis-open/dita-stylesheets/blob/master/CONTRIBUTING.md#public-participation-invited">"Public Participation Invited</a>", contributions to this OASIS Open Repository are invited from all parties, whether affiliated with OASIS or not.  Participants must have a GitHub account, but no fees or OASIS membership obligations are required.  Participation is expected to be consistent with the <a href="https://www.oasis-open.org/policies-guidelines/open-repositories">OASIS Open Repository Guidelines and Procedures</a>, the open source <a href="https://github.com/oasis-open/dita-stylesheets/blob/master/LICENSE">LICENSE</a> designated for this particular repository, and the requirement for an <a href="https://www.oasis-open.org/resources/open-repositories/cla/individual-cla">Individual Contributor License Agreement</a> that governs intellectual property.</p>

</div>

<div>
<h2><a id="purposeStatement">Statement of Purpose</a></h2>

<p>Statement of Purpose for this OASIS Open Repository (dita-stylesheets) as <a href="https://lists.oasis-open.org/archives/dita/201612/msg00094.html">proposed</a> and <a href="https://lists.oasis-open.org/archives/dita/201612/msg00114.html">approved</a> [<a href="https://issues.oasis-open.org/browse/TCADMIN-2523">bis</a>] by the TC:</p>

<p>This repository was created to support development and maintenance of the style sheets and other resources that are used to build OASIS-styled publications from DITA source. This project current can produce the following documents:</p>

<ul>
<li>OASIS specifications</li>
<li>OASIS errata documents</li>
<li>OASIS committee notes</li>
</ul>

<!-- Develop and maintain the style sheets and other resources that are used to build OASIS-styled publications from DITA source. This project current can produce the following documents: ...
* OASIS specifications
* OASIS errata documents
* OASIS committee notes
 -->

<!--
d1: OASIS Open Repository: Developing style sheets and other resources that can be used to build OASIS-styled publications from DITA source
 -->


</div>

<div><h2><a id="purposeClarifications">Additions to Statement of Purpose</a></h2>

<p>Repository Maintainers may include here any clarifications &mdash; any additional sections, subsections, and paragraphs that the Maintainer(s) wish to add as descriptive text, reflecting (sub-) project status, milestones, releases, modifications to statement of purpose, etc.  The project Maintainers will create and maintain this content on behalf of the participants.</p>
</div>

<div><h2><a id="ditaOtIntegration">Stylesheet plugin integration with the DITA Open Toolkit</a></h2>
<p>Plugin development is being done using dita-ot-2.4.1. Do the following to create the runtime environment:</p>
<ol>
<li>Install the version of the DITA Open Toolkit (dita-ot) that is being used for development.</li>
<li>Clone this repository to a temporary directory</li>
<li>Move the entire contents of the cloned instance, including hidden files and hidden directories, to the dita-ot plugins directory</li>
<li>If you are planning on contributing development work, update the .gitignore file in the plugins directory to exclude any additional
plugins that you may have added after installing the dita-ot. This is important because we do not want those plugins being pushed back to GitHub.</li>
<li>Run the dita command with the --install option.</li>
</ol>
</div>

<div>
<h2><a id="maintainers">Maintainers</a></h2>

<p>Open Repository <a href="https://www.oasis-open.org/resources/open-repositories/maintainers-guide">Maintainers</a> are responsible for oversight of this project's community development activities, including evaluation of GitHub <a href="https://github.com/oasis-open/dita-stylesheets/blob/master/CONTRIBUTING.md#fork-and-pull-collaboration-model">pull requests</a> and <a href="https://www.oasis-open.org/policies-guidelines/open-repositories#repositoryManagement">preserving</a> open source principles of openness and fairness. Maintainers are recognized and trusted experts who serve to implement community goals and consensus design preferences.</p>

<p>Initially, the associated TC members have designated one or more persons to serve as Maintainer(s); subsequently, participating community members may select additional or substitute Maintainers, per <a href="https://www.oasis-open.org/resources/open-repositories/maintainers-guide#additionalMaintainers">consensus agreements</a>.</p>

<p><b><a id="currentMaintainers">Current Maintainers of this Open Repository</a></b></p>

<ul>

<li><a href="mailto:kris@eberleinconsulting.com">Kristen James Eberlein</a>; GitHub ID: <a href="https://github.com/keberlein">keberlein</a>; WWW: <a href="http://eberleinconsulting.com/">Eberlein Consulting</a></li>

<li><a href="mailto:bob.thomas@tagsmiths.com">Bob Thomas</a>; GitHub ID: <a href="https://github.com/robertnthomas">robertnthomas</a>; OASIS Individual Member</li>

<!--
<li><a href="mailto:luc.boutier@fastconnect.fr">Luc Boutier</a>; GitHub ID: <a href="https://github.com/lucboutier/">https://github.com/lucboutier/</a>; WWW: <a href="http://www.fastconnect.fr/">FastConnect SAS</a></li>  -->
</ul>

</div>

<div><h2><a id="aboutOpenRepos">About OASIS Open Repositories</a></h2>

<p><ul>
<li><a href="https://www.oasis-open.org/resources/open-repositories/">Open Repositories: Overview and Resources</a></li>
<li><a href="https://www.oasis-open.org/resources/open-repositories/faq">Frequently Asked Questions</a></li>
<li><a href="https://www.oasis-open.org/resources/open-repositories/licenses">Open Source Licenses</a></li>
<li><a href="https://www.oasis-open.org/resources/open-repositories/cla">Contributor License Agreements (CLAs)</a></li>
<li><a href="https://www.oasis-open.org/resources/open-repositories/maintainers-guide">Maintainers' Guidelines and Agreement</a></li>
</ul></p>

</div>

<div><h2><a id="feedback">Feedback</a></h2>

<p>Questions or comments about this Open Repository's activities should be composed as GitHub issues or comments. If use of an issue/comment is not possible or appropriate, questions may be directed by email to the Maintainer(s) <a href="#currentMaintainers">listed above</a>.  Please send general questions about Open Repository participation to OASIS Staff at <a href="mailto:repository-admin@oasis-open.org">repository-admin@oasis-open.org</a> and any specific CLA-related questions to <a href="mailto:repository-cla@oasis-open.org">repository-cla@oasis-open.org</a>.</p>

</div></div>

