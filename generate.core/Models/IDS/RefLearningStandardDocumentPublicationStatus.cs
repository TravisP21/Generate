﻿using System;
using System.Collections.Generic;

namespace generate.core.Models.IDS
{
    public partial class RefLearningStandardDocumentPublicationStatus
    {
        public RefLearningStandardDocumentPublicationStatus()
        {
            LearningStandardDocument = new HashSet<LearningStandardDocument>();
        }

        public int RefLearningStandardDocumentPublicationStatusId { get; set; }
        public string Description { get; set; }
        public string Code { get; set; }
        public string Definition { get; set; }
        public int? RefJurisdictionId { get; set; }
        public decimal? SortOrder { get; set; }

        public virtual ICollection<LearningStandardDocument> LearningStandardDocument { get; set; }
        public virtual Organization RefJurisdiction { get; set; }
    }
}