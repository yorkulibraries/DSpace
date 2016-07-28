<?xml version="1.0" encoding="UTF-8" ?>
<!-- 


    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/
	Developed by DSpace @ Lyncode <dspace@lyncode.com>

 -->
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:doc="http://www.lyncode.com/xoai"
	version="1.0">
	<xsl:output omit-xml-declaration="yes" method="xml" indent="yes" />
	
	<xsl:template match="/">
		<mods:mods xmlns:mods="http://www.loc.gov/mods/v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-1.xsd">
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element/doc:element/doc:field[@name='value']">
				<mods:name>
                                        <mods:role><mods:roleTerm type="text"><xsl:value-of select="../../@name" /></mods:roleTerm></mods:role>
					<mods:namePart><xsl:value-of select="." /></mods:namePart>
				</mods:name>
			</xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element/doc:field[@name='value']">
                                <mods:name>
                                        <mods:namePart><xsl:value-of select="." /></mods:namePart>
                                </mods:name>
                        </xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='creator']/doc:element/doc:field[@name='value']">
                                <mods:name>
                                        <mods:namePart><xsl:value-of select="." /></mods:namePart>
                                </mods:name>
                        </xsl:for-each>
			<xsl:if test="doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[@name='accessioned']/doc:element/doc:field[@name='value']">
			<mods:extension>
				<mods:dateAccessioned encoding="iso8601">
					<xsl:value-of select="doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[@name='accessioned']/doc:element/doc:field[@name='value']/text()"></xsl:value-of>
				</mods:dateAccessioned>
			</mods:extension>
			</xsl:if>
			<xsl:if test="doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[@name='available']/doc:element/doc:field[@name='value']">
			<mods:extension>
				<mods:dateAvailable encoding="iso8601">
					<xsl:value-of select="doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[@name='available']/doc:element/doc:field[@name='value']/text()"></xsl:value-of>
				</mods:dateAvailable>
			</mods:extension>
			</xsl:if>
                        <xsl:if test="doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[@name='submitted']/doc:element/doc:field[@name='value']">
                        <mods:extension>
                                <mods:dateSubmitted encoding="iso8601">
                                        <xsl:value-of select="doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[@name='submitted']/doc:element/doc:field[@name='value']/text()"></xsl:value-of>
                                </mods:dateSubmitted>
                        </mods:extension>
                        </xsl:if>
			<xsl:if test="doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[@name='issued']/doc:element/doc:field[@name='value']">
			<mods:originInfo>
				<mods:dateIssued encoding="iso8601">
					<xsl:value-of select="doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[@name='issued']/doc:element/doc:field[@name='value']/text()"></xsl:value-of>
				</mods:dateIssued>
			</mods:originInfo>
			</xsl:if>
                        <xsl:if test="doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[@name='created']/doc:element/doc:field[@name='value']">
                        <mods:originInfo>
                                <mods:dateCreated encoding="iso8601">
                                        <xsl:value-of select="doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[@name='created']/doc:element/doc:field[@name='value']/text()"></xsl:value-of>
                                </mods:dateCreated>
                        </mods:originInfo>
                        </xsl:if>
                        <xsl:if test="doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[@name='copyright']/doc:element/doc:field[@name='value']">
                        <mods:originInfo>
                                <mods:copyrightDate encoding="iso8601">
                                        <xsl:value-of select="doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[@name='copyright']/doc:element/doc:field[@name='value']/text()"></xsl:value-of>
                                </mods:copyrightDate>
                        </mods:originInfo>
                        </xsl:if>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='format']/doc:element/doc:field[@name='value']">
                        <mods:physicalDescription>
                                <mods:form><xsl:value-of select="." /></mods:form>
                        </mods:physicalDescription>
                        </xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='format']/doc:element[@name='extent']/doc:element/doc:field[@name='value']">
                        <mods:physicalDescription>
                                <mods:extent><xsl:value-of select="." /></mods:extent>
                        </mods:physicalDescription>
                        </xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='format']/doc:element[@name='medium']/doc:element/doc:field[@name='value']">
                        <mods:physicalDescription>
                                <mods:form><xsl:value-of select="." /></mods:form>
                        </mods:physicalDescription>
                        </xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='format']/doc:element[@name='mimetype']/doc:element/doc:field[@name='value']">
                        <mods:physicalDescription>
                                <mods:internetMediaType><xsl:value-of select="." /></mods:internetMediaType>
                        </mods:physicalDescription>
                        </xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='identifier']/doc:element/doc:field[@name='value']">
                        <mods:identifier>
                            <xsl:value-of select="." />
                        </mods:identifier>
                        </xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='identifier']/doc:element[@name != 'uri']/doc:element/doc:field[@name='value']">
			<mods:identifier>
				<xsl:attribute name="type">
					<xsl:value-of select="../../@name" />
				</xsl:attribute>
				<xsl:value-of select="." />
			</mods:identifier>
			</xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='identifier']/doc:element[@name='uri']/doc:element/doc:field[@name='value']">
                                <mods:location><mods:url><xsl:value-of select="." /></mods:url></mods:location>
                        </xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element/doc:field[@name='value']">
                                <mods:note><xsl:value-of select="." /></mods:note>
                        </xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element[@name='abstract']/doc:element/doc:field[@name='value']">
				<mods:abstract><xsl:value-of select="." /></mods:abstract>
			</xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element[@name='provenance']/doc:element/doc:field[@name='value']">
                                <mods:note type="provenance"><xsl:value-of select="." /></mods:note>
                        </xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element[@name='sponsorship']/doc:element/doc:field[@name='value']">
                                <mods:note type="sponsorship"><xsl:value-of select="." /></mods:note>
                        </xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element[@name='statementofresponsibility']/doc:element/doc:field[@name='value']">
                                <mods:note type="statement of responsibility"><xsl:value-of select="." /></mods:note>
                        </xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element[@name='tableofcontents']/doc:element/doc:field[@name='value']">
                                <mods:tableOfContents><xsl:value-of select="." /></mods:tableOfContents>
                        </xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element[@name='uri']/doc:element/doc:field[@name='value']">
                            <mods:note>
                                <xsl:attribute name="xlink:simpleLink" namespace="http://www.w3.org/1999/xlink">
                                    <xsl:value-of select="." />
                                </xsl:attribute>
                                <xsl:value-of select="." />
                            </mods:note>
                        </xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='language']/doc:element/doc:element/doc:field[@name='value']">
			<mods:language>
				<mods:languageTerm authority="rfc3066"><xsl:value-of select="." /></mods:languageTerm>
			</mods:language>
			</xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='publisher']/doc:element/doc:field[@name='value']">
                        <mods:originInfo>
                                <mods:publisher><xsl:value-of select="." /></mods:publisher>
                        </mods:originInfo>
                        </xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element[@name='haspart']/doc:element/doc:field[@name='value']">
                                <mods:relatedItem type="constituent"><xsl:value-of select="." /></mods:relatedItem>
                        </xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element[@name='hasversion']/doc:element/doc:field[@name='value']">
                                <mods:relatedItem type="otherVersion"><xsl:value-of select="." /></mods:relatedItem>
                        </xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element[@name='isbasedon']/doc:element/doc:field[@name='value']">
                                <mods:relatedItem type="original"><xsl:value-of select="." /></mods:relatedItem>
                        </xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element[@name='isformatof']/doc:element/doc:field[@name='value']">
                                <mods:relatedItem type="otherFormat"><xsl:value-of select="." /></mods:relatedItem>
                        </xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element[@name='ispartof']/doc:element/doc:field[@name='value']">
                                <mods:relatedItem type="host"><xsl:value-of select="." /></mods:relatedItem>
                        </xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element[@name='ispartofseries']/doc:element/doc:field[@name='value']">
                                <mods:relatedItem type="series"><mods:titleInfo><mods:title><xsl:value-of select="." /></mods:title></mods:titleInfo></mods:relatedItem>
                        </xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element[@name='isreferencedby']/doc:element/doc:field[@name='value']">
                                <mods:relatedItem type="isReferencedBy"><xsl:value-of select="." /></mods:relatedItem>
                        </xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element[@name='isreplacedby']/doc:element/doc:field[@name='value']">
                                <mods:relatedItem type="succeeding"><xsl:value-of select="." /></mods:relatedItem>
                        </xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element[@name='isversionof']/doc:element/doc:field[@name='value']">
                                <mods:relatedItem type="otherVersion"><xsl:value-of select="." /></mods:relatedItem>
                        </xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element[@name='replaces']/doc:element/doc:field[@name='value']">
                                <mods:relatedItem type="preceeding"><xsl:value-of select="." /></mods:relatedItem>
                        </xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element[@name='requires']/doc:element/doc:field[@name='value']">
                                <mods:note type="requires"><xsl:value-of select="." /></mods:note>
                        </xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element[@name='uri']/doc:element/doc:field[@name='value']">
                                <mods:relatedItem><mods:location><mods:url><xsl:value-of select="." /></mods:url></mods:location></mods:relatedItem>
                        </xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element[@name='haspart']/doc:element/doc:field[@name='value']">
                                <mods:relatedItem type="constituent"><xsl:value-of select="." /></mods:relatedItem>
                        </xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='rights']/doc:element[@name='uri']/doc:element/doc:field[@name='value']">
			<mods:accessCondition>
                            <xsl:attribute name="xlink:simpleLink" namespace="http://www.w3.org/1999/xlink">
                                <xsl:value-of select="." />
                            </xsl:attribute>
                            <xsl:value-of select="." />
                        </mods:accessCondition>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='rights']/doc:element/doc:field[@name='value']">
			<mods:accessCondition type="useAndReproduction"><xsl:value-of select="." /></mods:accessCondition>
			</xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='source']/doc:element[@name='uri']/doc:element/doc:field[@name='value']">
                        <mods:relatedItem type="original">
                            <xsl:attribute name="xlink:simpleLink" namespace="http://www.w3.org/1999/xlink">
                                <xsl:value-of select="." />
                            </xsl:attribute>
                            <xsl:value-of select="." />
                        </mods:relatedItem>
                        </xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='source']/doc:element/doc:field[@name='value']">
                        <mods:relatedItem type="original"><xsl:value-of select="." /></mods:relatedItem>
                        </xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='subject']/doc:element/doc:field[@name='value']">
			<mods:subject>
				<mods:topic><xsl:value-of select="." /></mods:topic>
			</mods:subject>
			</xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='subject']/doc:element[@name='classification']/doc:element/doc:field[@name='value']">
                        <mods:classification>
                                <xsl:value-of select="." />
                        </mods:classification>
                        </xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='subject']/doc:element[@name='ddc']/doc:element/doc:field[@name='value']">
                        <mods:classification authority="ddc">
                                <xsl:value-of select="." />
                        </mods:classification>
                        </xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='subject']/doc:element[@name='lcc']/doc:element/doc:field[@name='value']">
                        <mods:classification authority="lcc">
                                <xsl:value-of select="." />
                        </mods:classification>
                        </xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='subject']/doc:element[@name='lcsh']/doc:element/doc:field[@name='value']">
                        <mods:subject authority="lcsh">
                                <mods:topic><xsl:value-of select="." /></mods:topic>
                        </mods:subject>
                        </xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='subject']/doc:element[@name='mesh']/doc:element/doc:field[@name='value']">
                        <mods:subject authority="mesh">
                                <mods:topic><xsl:value-of select="." /></mods:topic>
                        </mods:subject>
                        </xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='subject']/doc:element[@name='other']/doc:element/doc:field[@name='value']">
                        <mods:subject authority="local">
                                <mods:topic><xsl:value-of select="." /></mods:topic>
                        </mods:subject>
                        </xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='title']/doc:element/doc:field[@name='value']">
			<mods:titleInfo>
				<mods:title><xsl:value-of select="." /></mods:title>
			</mods:titleInfo>
			</xsl:for-each>
                        <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='title']/doc:element[@name='alternative']/doc:element/doc:field[@name='value']">
                        <mods:titleInfo  type="alternative">
                                <mods:title><xsl:value-of select="." /></mods:title>
                        </mods:titleInfo>
                        </xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field[@name='value']">
			<mods:genre><xsl:value-of select="." /></mods:genre>
			</xsl:for-each>
		</mods:mods>
	</xsl:template>
</xsl:stylesheet>
