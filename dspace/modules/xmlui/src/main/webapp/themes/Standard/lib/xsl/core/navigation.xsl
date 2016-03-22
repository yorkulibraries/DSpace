<xsl:stylesheet xmlns:i18n="http://apache.org/cocoon/i18n/2.1"
        xmlns:dri="http://di.tamu.edu/DRI/1.0/"
        xmlns:mets="http://www.loc.gov/METS/"
        xmlns:xlink="http://www.w3.org/TR/xlink/"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
        xmlns:dim="http://www.dspace.org/xmlns/dspace/dim"
        xmlns:xhtml="http://www.w3.org/1999/xhtml"
        xmlns:mods="http://www.loc.gov/mods/v3"
        xmlns:dc="http://purl.org/dc/elements/1.1/"
        xmlns="http://www.w3.org/1999/xhtml"
        xmlns:confman="org.dspace.core.ConfigurationManager"
        exclude-result-prefixes="i18n dri mets xlink xsl dim xhtml mods dc">

    <xsl:output indent="yes"/>

    <!-- YDJ: to hide community/collection stats - Dec 16, 2013 -->
    <xsl:template match="dri:options/dri:list[@id='aspect.statistics.Navigation.list.statistics']">
        <xsl:if test="/dri:document/dri:body/dri:div[@id='aspect.artifactbrowser.ItemViewer.div.item-view']">
            <h1 class="ds-option-set-head">
                <i18n:text>xmlui.statistics.Navigation.title</i18n:text>
            </h1>
            <div id="aspect_statistics_Navigation_list_statistics" class="ds-option-set">
                <ul class="ds-simple-list">
                    <li>
                        <a href="{confman:getProperty('dspace.baseUrl')}{$context-path}/{$request-uri}/statistics">
                            <i18n:text>xmlui.statistics.Navigation.view</i18n:text>
                        </a>
                    </li>
                </ul>
            </div>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
