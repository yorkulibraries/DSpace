<!--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

-->
<!--
    Rendering specific to the item display page.

    Author: art.lowel at atmire.com
    Author: lieven.droogmans at atmire.com
    Author: ben at atmire.com
    Author: Alexey Maslov

-->
<xsl:stylesheet xmlns:i18n="http://apache.org/cocoon/i18n/2.1" xmlns:dri="http://di.tamu.edu/DRI/1.0/" xmlns:mets="http://www.loc.gov/METS/" xmlns:dim="http://www.dspace.org/xmlns/dspace/dim" xmlns:xlink="http://www.w3.org/TR/xlink/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:ore="http://www.openarchives.org/ore/terms/" xmlns:oreatom="http://www.openarchives.org/ore/atom/" xmlns="http://www.w3.org/1999/xhtml" xmlns:xalan="http://xml.apache.org/xalan" xmlns:encoder="xalan://java.net.URLEncoder" xmlns:util="org.dspace.app.xmlui.utils.XSLUtils" exclude-result-prefixes="xalan encoder i18n dri mets dim  xlink xsl">
	<xsl:output indent="yes"/>
	<xsl:template name="itemSummaryView-DIM">
		<!-- Generate the info about the item from the metadata section -->
		<xsl:apply-templates select="./mets:dmdSec/mets:mdWrap[@OTHERMDTYPE='DIM']/mets:xmlData/dim:dim" mode="itemSummaryView-DIM"/>
		<!-- Generate the bitstream information from the file section -->
		<xsl:choose>
			<xsl:when test="./mets:fileSec/mets:fileGrp[@USE='CONTENT' or @USE='ORIGINAL']">
				<xsl:apply-templates select="./mets:fileSec/mets:fileGrp[@USE='CONTENT' or @USE='ORIGINAL']">
					<xsl:with-param name="context" select="."/>
					<xsl:with-param name="primaryBitstream" select="./mets:structMap[@TYPE='LOGICAL']/mets:div[@TYPE='DSpace Item']/mets:fptr/@FILEID"/>
				</xsl:apply-templates>
			</xsl:when>
			<!-- Special case for handling ORE resource maps stored as DSpace bitstreams -->
			<xsl:when test="./mets:fileSec/mets:fileGrp[@USE='ORE']">
				<xsl:apply-templates select="./mets:fileSec/mets:fileGrp[@USE='ORE']"/>
			</xsl:when>
			<xsl:otherwise>
				<h2>
					<i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-head</i18n:text>
				</h2>
				<table class="ds-table file-list">
					<tr class="ds-table-header-row">
						<th>
							<i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-file</i18n:text>
						</th>
						<th>
							<i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-size</i18n:text>
						</th>
						<th>
							<i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-format</i18n:text>
						</th>
						<th>
							<i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-view</i18n:text>
						</th>
					</tr>
					<tr>
						<td colspan="4">
							<p>
								<i18n:text>xmlui.dri2xhtml.METS-1.0.item-no-files</i18n:text>
							</p>
						</td>
					</tr>
				</table>
			</xsl:otherwise>
		</xsl:choose>
		<!-- Generate the Creative Commons license information from the file section (DSpace deposit license hidden by default)-->
		<xsl:apply-templates select="./mets:fileSec/mets:fileGrp[@USE='CC-LICENSE']"/>
	</xsl:template>
	<xsl:template match="dim:dim" mode="itemSummaryView-DIM">
		<table class="ds-includeSet-table summarytable">
			<xsl:call-template name="itemSummaryView-DIM-fields"/>
		</table>
	</xsl:template>
	<xsl:template name="itemSummaryView-DIM-fields">
		<xsl:param name="clause" select="'1'"/>
		<xsl:param name="phase" select="'even'"/>
		<xsl:variable name="otherPhase">
			<xsl:choose>
				<xsl:when test="$phase = 'even'">
					<xsl:text>odd</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>even</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<!-- *YDJ modified* Title row -->
			<xsl:when test="$clause = 1">
				<xsl:choose>
					<xsl:when test="count(dim:field[@element='title'][not(@qualifier)]) &gt; 1">
						<div id="title_head">
							<xsl:value-of select="dim:field[@element='title'][not(@qualifier)][1]/node()"/>
						</div>
						<br/>
						<tr>
							<td class="label-cell">
								<i18n:text>xmlui.dri2xhtml.METS-1.0.item-title</i18n:text>:</td>
							<td class="cell">
								<span>
									<xsl:for-each select="dim:field[@element='title'][not(@qualifier)]">
										<xsl:value-of select="./node()"/>
										<xsl:if test="count(following-sibling::dim:field[@element='title'][not(@qualifier)]) != 0">
											<xsl:text>; </xsl:text>
											<br/>
										</xsl:if>
									</xsl:for-each>
								</span>
							</td>
						</tr>
					</xsl:when>
					<xsl:when test="count(dim:field[@element='title'][not(@qualifier)]) = 1">
						<div id="title_head">
							<xsl:value-of select="dim:field[@element='title'][not(@qualifier)][1]/node()"/>
						</div>
						<br/>
						<tr>
							<td class="label-cell">
								<i18n:text>xmlui.dri2xhtml.METS-1.0.item-title</i18n:text>:</td>
							<td class="cell">
								<xsl:value-of select="dim:field[@element='title'][not(@qualifier)][1]/node()"/>
							</td>
						</tr>
					</xsl:when>
					<xsl:otherwise>
						<h1>
							<i18n:text>xmlui.dri2xhtml.METS-1.0.no-title</i18n:text>
						</h1>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:call-template name="itemSummaryView-DIM-fields">
					<xsl:with-param name="clause" select="($clause + 1)"/>
					<xsl:with-param name="phase" select="$otherPhase"/>
				</xsl:call-template>
			</xsl:when>
			<!-- Author(s) row -->
			 <xsl:when test="$clause = 2 and (dim:field[@element='contributor'][@qualifier='author'] or dim:field[@element='creator'] or dim:field[@element='contributor'])">
				<!-- <div class="simple-item-view-authors"> -->
				<tr>
					<td class="label-cell">
						<i18n:text>xmlui.dri2xhtml.METS-1.0.item-author</i18n:text>:</td>
					<td class="cell">
						<xsl:choose>
							<xsl:when test="dim:field[@element='contributor'][@qualifier='author']">
								<xsl:for-each select="dim:field[@element='contributor'][@qualifier='author']">
									<!--<span>-->
									<xsl:if test="@authority">
										<xsl:attribute name="class"><xsl:text>ds-dc_contributor_author-authority</xsl:text></xsl:attribute>
									</xsl:if>
									<xsl:copy-of select="node()"/>
									<!--</span>-->
									<xsl:if test="count(following-sibling::dim:field[@element='contributor'][@qualifier='author']) != 0">
										<br/>
									</xsl:if>
								</xsl:for-each>
							</xsl:when>
							<xsl:when test="dim:field[@element='creator']">
								<xsl:for-each select="dim:field[@element='creator']">
									<xsl:copy-of select="node()"/>
									<xsl:if test="count(following-sibling::dim:field[@element='creator']) != 0">
										<br/>
									</xsl:if>
								</xsl:for-each>
							</xsl:when>
							<xsl:when test="dim:field[@element='contributor']">
								<xsl:for-each select="dim:field[@element='contributor']">
									<xsl:copy-of select="node()"/>
									<xsl:if test="count(following-sibling::dim:field[@element='contributor']) != 0">
										<br/>
									</xsl:if>
								</xsl:for-each>
							</xsl:when>
							<xsl:otherwise>
								<i18n:text>xmlui.dri2xhtml.METS-1.0.no-author</i18n:text>
							</xsl:otherwise>
						</xsl:choose>
						<!--</div>-->
					</td>
				</tr>
				<xsl:call-template name="itemSummaryView-DIM-fields">
					<xsl:with-param name="clause" select="($clause + 1)"/>
					<xsl:with-param name="phase" select="$otherPhase"/>
				</xsl:call-template>
			</xsl:when>

			<!-- *YDJ* Identifier row -->
			<xsl:when test="$clause = 3 and (dim:field[@element='identifier' and not(@qualifier)])">
				<tr>
					<td class="label-cell">
						<i18n:text>xmlui.dri2xhtml.METS-1.0.item-identifier</i18n:text>:</td>
					<td class="cell">
						<xsl:for-each select="dim:field[@element='identifier' and not(@qualifier)]">
							<xsl:copy-of select="./node()"/>
							<xsl:if test="count(following-sibling::dim:field[@element='identifier' and not(@qualifier)]) != 0">
	                    	;
	                    </xsl:if>
						</xsl:for-each>
					</td>
				</tr>
				<xsl:call-template name="itemSummaryView-DIM-fields">
					<xsl:with-param name="clause" select="($clause + 1)"/>
					<xsl:with-param name="phase" select="$otherPhase"/>
				</xsl:call-template>
			</xsl:when>
			<!-- Abstract row -->
			<xsl:when test="$clause = 4 and (dim:field[@element='description' and @qualifier='abstract'])">
				<tr>
					<td class="label-cell">
						<i18n:text>xmlui.dri2xhtml.METS-1.0.item-abstract</i18n:text>:</td>
					<td class="cell">
						<xsl:for-each select="dim:field[@element='description' and @qualifier='abstract']">
							<!--<xsl:copy-of select="./node()"/>-->
							<xsl:call-template name="linebreak">
								<xsl:with-param name="text" select="./node()"/>
							</xsl:call-template>							
							<xsl:if test="count(following-sibling::dim:field[@element='description' and @qualifier='abstract']) != 0">
								<div class="spacer">&#160;</div>
							</xsl:if>
						</xsl:for-each>
						<xsl:if test="count(dim:field[@element='description' and @qualifier='abstract']) &gt; 1">
							<div class="spacer">&#160;</div>
						</xsl:if>
					</td>
				</tr>
				<xsl:call-template name="itemSummaryView-DIM-fields">
					<xsl:with-param name="clause" select="($clause + 1)"/>
					<xsl:with-param name="phase" select="$otherPhase"/>
				</xsl:call-template>
			</xsl:when>
			<!-- Description row -->
			<xsl:when test="$clause = 4 and (dim:field[@element='description' and not(@qualifier)])">
				<tr>
					<td class="label-cell">
						<i18n:text>xmlui.dri2xhtml.METS-1.0.item-description</i18n:text>:</td>
					<td class="cell">
						<xsl:if test="count(dim:field[@element='description' and not(@qualifier)]) &gt; 1 and not(count(dim:field[@element='description' and @qualifier='abstract']) &gt; 1)">
						<!--	<div class="spacer">&#160;</div> -->
						</xsl:if>
						<xsl:for-each select="dim:field[@element='description' and not(@qualifier)]">
							<xsl:copy-of select="./node()"/>
							<xsl:if test="count(following-sibling::dim:field[@element='description' and not(@qualifier)]) != 0">
								<div class="spacer">&#160;</div>
							</xsl:if>
						</xsl:for-each>
						<xsl:if test="count(dim:field[@element='description' and not(@qualifier)]) &gt; 1">
							<div class="spacer">&#160;</div>
						</xsl:if>
					</td>
				</tr>
				<xsl:call-template name="itemSummaryView-DIM-fields">
					<xsl:with-param name="clause" select="($clause + 1)"/>
					<xsl:with-param name="phase" select="$otherPhase"/>
				</xsl:call-template>
			</xsl:when>
			<!-- *YDJ* Sponsorship row -->
			<xsl:when test="$clause = 5 and (dim:field[@element='description' and @qualifier='sponsorship'])">
				<tr>
					<td class="label-cell">
						<i18n:text>xmlui.dri2xhtml.METS-1.0.item-sponsorship</i18n:text>:</td>
					<td class="cell">
						<xsl:for-each select="dim:field[@element='description' and @qualifier='sponsorship']">
							<xsl:copy-of select="./node()"/>
							<xsl:if test="count(following-sibling::dim:field[@element='description' and @qualifier='sponsorship']) != 0">
	                    	;
	                    </xsl:if>
						</xsl:for-each>
					</td>
				</tr>
				<xsl:call-template name="itemSummaryView-DIM-fields">
					<xsl:with-param name="clause" select="($clause + 1)"/>
					<xsl:with-param name="phase" select="$otherPhase"/>
				</xsl:call-template>
			</xsl:when>
			<!-- *YDJ* Subject row -->
			<xsl:when test="$clause = 6 and (dim:field[@element='subject' and not(@qualifier)])">
				<tr>
					<td class="label-cell">
						<i18n:text>xmlui.dri2xhtml.METS-1.0.item-subject</i18n:text>:</td>
					<td class="cell">
						<xsl:for-each select="dim:field[@element='subject' and not(@qualifier)]">
							<!--<encoder:encode>-->
							<a style="line-height: 0%">
								<xsl:attribute name="href"><xsl:value-of select="concat($context-path,'/browse?type=subject&#38;value=')"/><xsl:copy-of select="./node()"/></xsl:attribute>
								<xsl:copy-of select="./node()"/>
							</a>
							<!--</encoder:encode>-->
							<xsl:if test="count(following-sibling::dim:field[@element='subject' and not(@qualifier)]) != 0">
								<br/>
							</xsl:if>
						</xsl:for-each>
					</td>
				</tr>
				<xsl:call-template name="itemSummaryView-DIM-fields">
					<xsl:with-param name="clause" select="($clause + 1)"/>
					<xsl:with-param name="phase" select="$otherPhase"/>
				</xsl:call-template>
			</xsl:when>
			<!-- *YDJ* Type row -->
			<xsl:when test="$clause = 7 and (dim:field[@element='type' and not(@qualifier)])">
				<tr>
					<td class="label-cell">
						<i18n:text>xmlui.dri2xhtml.METS-1.0.item-type</i18n:text>:</td>
					<td class="cell">
						<xsl:for-each select="dim:field[@element='type' and not(@qualifier)]">
							<xsl:copy-of select="./node()"/>
							<xsl:if test="count(following-sibling::dim:field[@element='type' and not(@qualifier)]) != 0">
	                    	;
	                    </xsl:if>
						</xsl:for-each>
					</td>
				</tr>
				<xsl:call-template name="itemSummaryView-DIM-fields">
					<xsl:with-param name="clause" select="($clause + 1)"/>
					<xsl:with-param name="phase" select="$otherPhase"/>
				</xsl:call-template>
			</xsl:when>
			<!-- *YDJ* Right(s) row -->
			<xsl:when test="$clause = 8 and (dim:field[@element='rights' and not(@qualifier)] or dim:field[@element='rights' and @qualifier='article'] or dim:field[@element='rights' and @qualifier='journal'] or dim:field[@element='rights' and @qualifier='publisher'] or dim:field[@element='rights' and @qualifier='uri'])">
				<tr>
					<td class="label-cell">
						<i18n:text>xmlui.dri2xhtml.METS-1.0.item-rights</i18n:text>:</td>
					<td class="cell">
						<xsl:variable name="url_flag" select="./dim:field[@element='rights' and not(@qualifier)]"/>
						<xsl:variable name="url_flag2" select="./dim:field[@element='rights' and @qualifier='article']"/>
						<xsl:variable name="url_flag3" select="./dim:field[@element='rights' and @qualifier='journal']"/>
						<xsl:variable name="url_flag4" select="./dim:field[@element='rights' and @qualifier='publisher']"/>
						<xsl:variable name="url_flag5" select="./dim:field[@element='rights' and @qualifier='uri']"/>
						<xsl:if test="string($url_flag) != ''">
							<xsl:choose>
								<xsl:when test="substring($url_flag,1,4) = 'http'">
									<a>
										<xsl:attribute name="href"><xsl:copy-of select="$url_flag"/></xsl:attribute>
										<xsl:copy-of select="$url_flag"/>
									</a>
									<br/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:copy-of select="$url_flag"/><br/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
						<xsl:if test="(string($url_flag) = '' and string($url_flag2) != '') or (string($url_flag2) != string($url_flag))">
							<xsl:choose>
								<xsl:when test="substring($url_flag2,1,4) = 'http'">
									<a>
										<xsl:attribute name="href"><xsl:copy-of select="$url_flag2"/></xsl:attribute>
										<xsl:copy-of select="$url_flag2"/>
									</a>
									<br/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:copy-of select="$url_flag2"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
						<xsl:if test="(string($url_flag) = '' and string($url_flag2) = '' and string($url_flag3) != '') or (string($url_flag3) != string($url_flag2))">
							<xsl:choose>
								<xsl:when test="substring($url_flag3,1,4) = 'http'">
									<a>
										<xsl:attribute name="href"><xsl:copy-of select="$url_flag3"/></xsl:attribute>
										<xsl:copy-of select="$url_flag3"/>
									</a>
									<br/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:copy-of select="$url_flag3"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
						<xsl:if test="(string($url_flag) = '' and string($url_flag2) = '' and string($url_flag3) = '' and string($url_flag4) != '') or (string($url_flag4) != string($url_flag3))">
							<xsl:choose>
								<xsl:when test="substring($url_flag4,1,4) = 'http'">
									<a>
										<xsl:attribute name="href"><xsl:copy-of select="$url_flag4"/></xsl:attribute>
										<xsl:copy-of select="$url_flag4"/>
									</a>
									<br/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:copy-of select="$url_flag4"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
						<xsl:if test="(string($url_flag) = '' and string($url_flag2) = '' and string($url_flag3) = '' and string($url_flag4) = '' and string($url_flag5) != '') or (string($url_flag5) != string($url_flag4))">
							<xsl:choose>
								<xsl:when test="substring($url_flag5,1,4) = 'http'">
									<a>
										<xsl:attribute name="href"><xsl:copy-of select="$url_flag5"/></xsl:attribute>
										<xsl:copy-of select="$url_flag5"/>
									</a>
									<br/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:copy-of select="$url_flag5"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
					</td>
				</tr>
				<xsl:call-template name="itemSummaryView-DIM-fields">
					<xsl:with-param name="clause" select="($clause + 1)"/>
					<xsl:with-param name="phase" select="$otherPhase"/>
				</xsl:call-template>
			</xsl:when>
			<!-- identifier.uri row -->
			<xsl:when test="$clause = 9 and (dim:field[@element='identifier' and @qualifier='uri'])">
				<tr>
					<td class="label-cell">
						<i18n:text>xmlui.dri2xhtml.METS-1.0.item-uri</i18n:text>:</td>
					<td class="cell">
						<xsl:for-each select="dim:field[@element='identifier' and @qualifier='uri']">
							<a>
								<xsl:attribute name="href"><xsl:copy-of select="./node()"/></xsl:attribute>
								<xsl:copy-of select="./node()"/>
							</a>
							<xsl:if test="count(following-sibling::dim:field[@element='identifier' and @qualifier='uri']) != 0">
								<br/>
							</xsl:if>
						</xsl:for-each>
					</td>
				</tr>
				<xsl:call-template name="itemSummaryView-DIM-fields">
					<xsl:with-param name="clause" select="($clause + 1)"/>
					<xsl:with-param name="phase" select="$otherPhase"/>
				</xsl:call-template>
			</xsl:when>
						
			<!-- *YDJ* Publisher row -->
			<xsl:when test="$clause = 10 and (dim:field[@element='publisher' and not(@qualifier)])">
				<tr>
					<td class="label-cell">
						<i18n:text>xmlui.dri2xhtml.METS-1.0.item-publisher</i18n:text>:</td>
					<td class="cell">
						<xsl:for-each select="dim:field[@element='publisher' and not(@qualifier)]">
							<xsl:copy-of select="./node()"/>
							<xsl:if test="count(following-sibling::dim:field[@element='publisher' and not(@qualifier)]) != 0">
	                    	;
	                    </xsl:if>
						</xsl:for-each>
					</td>
				</tr>
				<xsl:call-template name="itemSummaryView-DIM-fields">
					<xsl:with-param name="clause" select="($clause + 1)"/>
					<xsl:with-param name="phase" select="$otherPhase"/>
				</xsl:call-template>
			</xsl:when>
			
			<!-- *YDJ* series row -->
			<xsl:when test="$clause = 11 and (dim:field[@element='relation' and @qualifier='ispartofseries'])">
				<tr>
					<td class="label-cell">						
							<i18n:text>xmlui.dri2xhtml.METS-1.0.item-ispartofseries</i18n:text>:
					</td>
					<td class="cell">
						<xsl:for-each select="dim:field[@element='relation' and @qualifier='ispartofseries']">
							<a>
								<xsl:attribute name="href">
								      <xsl:value-of select="concat($context-path,'/browse?type=series&#38;value=')"/>
								      <xsl:copy-of select="./node()"/>
								</xsl:attribute>
								<xsl:copy-of select="./node()"/>
							</a>
							<xsl:if test="count(following-sibling::dim:field[@element='relation' and @qualifier='ispartofseries']) != 0">
	                    	;
	                    </xsl:if>
						</xsl:for-each>
					</td>
				</tr>
				<xsl:call-template name="itemSummaryView-DIM-fields">
					<xsl:with-param name="clause" select="($clause + 1)"/>
					<xsl:with-param name="phase" select="$otherPhase"/>
				</xsl:call-template>
			</xsl:when>
			
			<!-- *YDJ* Citation row -->
			<xsl:when test="$clause = 12 and (dim:field[@element='identifier' and @qualifier='citation'])">
				<tr>
					<td class="label-cell">
						<i18n:text>xmlui.dri2xhtml.METS-1.0.item-citation</i18n:text>:</td>
					<td class="cell">
						<xsl:for-each select="dim:field[@element='identifier' and @qualifier='citation']">
							<xsl:copy-of select="./node()"/>
							<xsl:if test="count(following-sibling::dim:field[@element='identifier' and @qualifier='citation']) != 0">
	                    	;
	                    </xsl:if>
						</xsl:for-each>
					</td>
				</tr>
				<xsl:call-template name="itemSummaryView-DIM-fields">
					<xsl:with-param name="clause" select="($clause + 1)"/>
					<xsl:with-param name="phase" select="$otherPhase"/>
				</xsl:call-template>
			</xsl:when>
			<!-- *YDJ* issn row -->
			<xsl:when test="$clause = 13 and (dim:field[@element='identifier' and @qualifier='issn'])">
				<tr>
					<td class="label-cell">						
							<i18n:text>xmlui.dri2xhtml.METS-1.0.item-issn</i18n:text>:
					</td>
					<td class="cell">
						<xsl:for-each select="dim:field[@element='identifier' and @qualifier='issn']">
							<xsl:copy-of select="./node()"/>
							<xsl:if test="count(following-sibling::dim:field[@element='identifier' and @qualifier='issn']) != 0">
	                    	;
	                    </xsl:if>
						</xsl:for-each>
					</td>
				</tr>
				<xsl:call-template name="itemSummaryView-DIM-fields">
					<xsl:with-param name="clause" select="($clause + 1)"/>
					<xsl:with-param name="phase" select="$otherPhase"/>
				</xsl:call-template>
			</xsl:when>
			<!-- *YDJ* isbn row -->
			<xsl:when test="$clause = 14 and (dim:field[@element='identifier' and @qualifier='isbn'])">
				<!--<tr class="ds-table-row {$phase}">-->
				<tr>
					<td class="label-cell">
						<i18n:text>xmlui.dri2xhtml.METS-1.0.item-isbn</i18n:text>:
					</td>
					<td class="cell">
						<xsl:for-each select="dim:field[@element='identifier' and @qualifier='isbn']">
							<xsl:copy-of select="./node()"/>
							<xsl:if test="count(following-sibling::dim:field[@element='identifier' and @qualifier='isbn']) != 0">
	                    	;
	                    </xsl:if>
						</xsl:for-each>
					</td>
				</tr>
				<xsl:call-template name="itemSummaryView-DIM-fields">
					<xsl:with-param name="clause" select="($clause + 1)"/>
					<xsl:with-param name="phase" select="$otherPhase"/>
				</xsl:call-template>
			</xsl:when>
			<!-- date.issued row -->
			<xsl:when test="$clause = 15 and (dim:field[@element='date' and @qualifier='issued'])">
				<tr>
					<td class="label-cell">
						<i18n:text>xmlui.dri2xhtml.METS-1.0.item-date</i18n:text>:</td>
					<td class="cell">
						<xsl:variable name="url_flag" select="./dim:field[@element='date' and @qualifier='issued']"/>
						
						<xsl:if test="string($url_flag) != ''">
							<xsl:choose>
								<xsl:when test="substring($url_flag,11,1) = 'T'">
									
										<xsl:copy-of select="substring($url_flag,1,10)"/>
									
									<br/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:copy-of select="substring($url_flag,1,35)"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
						<xsl:if test="count(following-sibling::dim:field[@element='date' and @qualifier='issued']) != 0">
								<br/>
						</xsl:if>

						<!--<xsl:for-each select="dim:field[@element='date' and @qualifier='issued']">
							<xsl:copy-of select="substring(./node(),1,10)"/>
							<xsl:if test="count(following-sibling::dim:field[@element='date' and @qualifier='issued']) != 0">
								<br/>
							</xsl:if>
						</xsl:for-each>-->
					</td>
				</tr>
				<xsl:call-template name="itemSummaryView-DIM-fields">
					<xsl:with-param name="clause" select="($clause + 1)"/>
					<xsl:with-param name="phase" select="$otherPhase"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$clause = 16 and $ds_item_view_toggle_url != ''">
				<p class="ds-paragraph item-view-toggle item-view-toggle-bottom">
					<a>
						<xsl:attribute name="href"><xsl:value-of select="$ds_item_view_toggle_url"/></xsl:attribute>
						<i18n:text>xmlui.ArtifactBrowser.ItemViewer.show_full</i18n:text>
					</a>
				</p>
			</xsl:when>
			<!-- recurse without changing phase if we didn't output anything -->
			<xsl:otherwise>
				<!-- IMPORTANT: This test should be updated if clauses are added! -->
				<xsl:if test="$clause &lt; 17">
					<xsl:call-template name="itemSummaryView-DIM-fields">
						<xsl:with-param name="clause" select="($clause + 1)"/>
						<xsl:with-param name="phase" select="$phase"/>
					</xsl:call-template>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- Function to replace \n -->
    <xsl:template name="linebreak">
       <xsl:param name="text" select="."/>
       <xsl:choose>
         <xsl:when test="contains($text, '&#xa;')">           
           <xsl:value-of select="substring-before($text, '&#xa;')"/>
			<br />
           <xsl:call-template name="linebreak">
             <xsl:with-param name="text" select="substring-after($text,'&#xa;')"/>
           </xsl:call-template>
         </xsl:when>
         <xsl:otherwise>
           <xsl:value-of select="$text"/>
         </xsl:otherwise>
       </xsl:choose>
    </xsl:template>
	<xsl:template match="dim:dim" mode="itemDetailView-DIM">
		<span class="Z3988">
			<xsl:attribute name="title"><xsl:call-template name="renderCOinS"/></xsl:attribute>
		</span>
		<table class="ds-includeSet-table detailtable">
			<xsl:apply-templates mode="itemDetailView-DIM"/>
		</table>
	</xsl:template>
	<xsl:template match="dim:field" mode="itemDetailView-DIM">
		<xsl:if test="not(@element='description' and @qualifier='provenance')">
			<tr>
				<xsl:attribute name="class"><xsl:text>ds-table-row </xsl:text><xsl:if test="(position() div 2 mod 2 = 0)">even </xsl:if><xsl:if test="(position() div 2 mod 2 = 1)">odd </xsl:if></xsl:attribute>
				<td class="label-cell">
					<xsl:value-of select="./@mdschema"/>
					<xsl:text>.</xsl:text>
					<xsl:value-of select="./@element"/>
					<xsl:if test="./@qualifier">
						<xsl:text>.</xsl:text>
						<xsl:value-of select="./@qualifier"/>
					</xsl:if>
				</td>
				<!-- *YDJ*-->
				<td class="cell1">
					<xsl:copy-of select="./node()"/>
					<xsl:if test="./@authority and ./@confidence">
						<xsl:call-template name="authorityConfidenceIcon">
							<xsl:with-param name="confidence" select="./@confidence"/>
						</xsl:call-template>
					</xsl:if>
				</td>
				<td class="cell2">
					<xsl:value-of select="./@language"/>
				</td>
			</tr>
		</xsl:if>
	</xsl:template>
	<!--dont render the item-view-toggle automatically in the summary view, only when it get's called-->
	<xsl:template match="dri:p[contains(@rend , 'item-view-toggle') and
        (preceding-sibling::dri:referenceSet[@type = 'summaryView'] or following-sibling::dri:referenceSet[@type = 'summaryView'])]">
    </xsl:template>
	<!-- dont render the head on the item view page -->
	<xsl:template match="dri:div[@n='item-view']/dri:head" priority="5">
    </xsl:template>
	<xsl:template match="mets:fileGrp[@USE='CONTENT']">
		<xsl:param name="context"/>
		<xsl:param name="primaryBitstream" select="-1"/>
		<h2>
			<i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-head</i18n:text>
		</h2>
		<div class="file-list">
			<xsl:choose>
				<!-- If one exists and it's of text/html MIME type, only display the primary bitstream -->
				<xsl:when test="mets:file[@ID=$primaryBitstream]/@MIMETYPE='text/html'">
					<xsl:apply-templates select="mets:file[@ID=$primaryBitstream]">
						<xsl:with-param name="context" select="$context"/>
					</xsl:apply-templates>
				</xsl:when>
				<!-- Otherwise, iterate over and display all of them -->
				<xsl:otherwise>
					<xsl:apply-templates select="mets:file">
						<!--Do not sort any more bitstream order can be changed-->
                        			<!--<xsl:sort data-type="number" select="boolean(./@ID=$primaryBitstream)" order="descending" />-->
                        			<!--<xsl:sort select="mets:FLocat[@LOCTYPE='URL']/@xlink:title"/>-->

						<xsl:with-param name="context" select="$context"/>
					</xsl:apply-templates>
				</xsl:otherwise>
			</xsl:choose>
		</div>
	</xsl:template>
	<xsl:template match="mets:file">
		<xsl:param name="context" select="."/>
		<div class="file-wrapper clearfix">
			<div class="thumbnail-wrapper">
				<a class="image-link">
					<xsl:attribute name="href"><xsl:value-of select="mets:FLocat[@LOCTYPE='URL']/@xlink:href"/></xsl:attribute>
					<xsl:choose>
						<xsl:when test="$context/mets:fileSec/mets:fileGrp[@USE='THUMBNAIL']/
                        mets:file[@GROUPID=current()/@GROUPID]">
							<img alt="Thumbnail">
								<xsl:attribute name="src"><xsl:value-of select="$context/mets:fileSec/mets:fileGrp[@USE='THUMBNAIL']/
                                    mets:file[@GROUPID=current()/@GROUPID]/mets:FLocat[@LOCTYPE='URL']/@xlink:href"/></xsl:attribute>
							</img>
						</xsl:when>
						<xsl:otherwise>
							<img alt="Icon" src="{concat($theme-path, '/images/mime.png')}" style="height: {$thumbnail.maxheight}px;"/>
						</xsl:otherwise>
					</xsl:choose>
				</a>
			</div>
			<div class="file-metadata" style="height: {$thumbnail.maxheight}px;">
				<table class="table-metadata"><tr>
					<td class="label-cell">
						<i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-name</i18n:text><xsl:text>:</xsl:text>						
					</td>
					<td class="cell">					
						<xsl:attribute name="title"><xsl:value-of select="mets:FLocat[@LOCTYPE='URL']/@xlink:title"/></xsl:attribute>
						<!--<xsl:value-of select="util:shortenString(mets:FLocat[@LOCTYPE='URL']/@xlink:title, 17, 5)"/>--> <xsl:value-of select="mets:FLocat[@LOCTYPE='URL']/@xlink:title"/>
					</td>
				</tr>
				<!-- File size always comes in bytes and thus needs conversion -->
				<tr>
					<td class="label-cell">
						<i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-size</i18n:text><xsl:text>:</xsl:text>						
					</td>
					<td class="cell">
						<xsl:choose>
							<xsl:when test="@SIZE &lt; 1024">
								<xsl:value-of select="@SIZE"/>
								<i18n:text>xmlui.dri2xhtml.METS-1.0.size-bytes</i18n:text>
							</xsl:when>
							<xsl:when test="@SIZE &lt; 1024 * 1024">
								<xsl:value-of select="substring(string(@SIZE div 1024),1,5)"/>
								<i18n:text>xmlui.dri2xhtml.METS-1.0.size-kilobytes</i18n:text>
							</xsl:when>
							<xsl:when test="@SIZE &lt; 1024 * 1024 * 1024">
								<xsl:value-of select="substring(string(@SIZE div (1024 * 1024)),1,5)"/>
								<i18n:text>xmlui.dri2xhtml.METS-1.0.size-megabytes</i18n:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="substring(string(@SIZE div (1024 * 1024 * 1024)),1,5)"/>
								<i18n:text>xmlui.dri2xhtml.METS-1.0.size-gigabytes</i18n:text>
							</xsl:otherwise>
						</xsl:choose>
					</td>
				</tr>
				<!-- Lookup File Type description in local messages.xml based on MIME Type.
         In the original DSpace, this would get resolved to an application via
         the Bitstream Registry, but we are constrained by the capabilities of METS
         and can't really pass that info through. -->
				<tr>
				    <td class="label-cell">
						<i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-format</i18n:text>
						<xsl:text>:</xsl:text>										
					</td>
					<td class="cell">					
						<xsl:call-template name="getFileTypeDesc">
							<xsl:with-param name="mimetype">
								<xsl:value-of select="substring-before(@MIMETYPE,'/')"/>
								<xsl:text>/</xsl:text>
								<xsl:value-of select="substring-after(@MIMETYPE,'/')"/>
							</xsl:with-param>
						</xsl:call-template>					
					</td>
				</tr>				
				<!-- Display the contents of 'Description' only if bitstream contains a description -->
				<xsl:if test="mets:FLocat[@LOCTYPE='URL']/@xlink:label != ''">
					<tr>
					    <td class="label-cell">
							<i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-description</i18n:text>
							<xsl:text>:</xsl:text>
						</td>
						<td class="cell">						
							<xsl:attribute name="title"><xsl:value-of select="mets:FLocat[@LOCTYPE='URL']/@xlink:label"/></xsl:attribute>
							<xsl:value-of select="mets:FLocat[@LOCTYPE='URL']/@xlink:label"/>							
							<!--<xsl:value-of select="util:shortenString(mets:FLocat[@LOCTYPE='URL']/@xlink:label, 17, 5)"/>-->						
						</td>
					</tr>
				</xsl:if>
				</table>
			</div>
			<div class="file-link" style="height: {$thumbnail.maxheight}px;">			
				<a>
					<xsl:attribute name="href"><xsl:value-of select="mets:FLocat[@LOCTYPE='URL']/@xlink:href"/></xsl:attribute>
					<i18n:text>xmlui.dri2xhtml.METS-1.0.item-files-viewOpen</i18n:text>
				</a>
			</div>
		</div><br></br><br></br>
	</xsl:template>
</xsl:stylesheet>
