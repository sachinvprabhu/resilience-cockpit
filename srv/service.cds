using { ResilienceCockpit as my } from '../db/schema.cds';

using { API_INFORECORD_PROCESS_SRV as external } from './external/API_INFORECORD_PROCESS_SRV';

@path : '/service/ResilienceCockpitService'
service ResilienceCockpitService
{
    @cds.redirection.target
    @odata.draft.bypass
    @odata.draft.enabled
    entity AlternateSuppliers as
        projection on my.AlternateSuppliers
        {
            *
        }
        // excluding
        // {
        //     Country
        // }
        actions
        {
            function SupplierItemCount
            (
            )
            returns Integer;

            action UpVote
            (
            )
            returns AlternateSuppliers;
            action DownVote
            (
            )
            returns AlternateSuppliers;
        };

    @cds.redirection.target
    entity SupplierMaterials as
        projection on my.SupplierMaterials;

    
    @cds.redirection.target
    entity AleternativeMaterials as
        projection on my.AleternativeMaterials;

    @cds.redirection.target
    entity A_PurchasingInfoRecord as
        projection on external.A_PurchasingInfoRecord
        {
            *
        }
        excluding
        {
            to_PurgInfoRecdOrgPlantData
        };
}

annotate ResilienceCockpitService with @requires :
[
    'authenticated-user'
];
